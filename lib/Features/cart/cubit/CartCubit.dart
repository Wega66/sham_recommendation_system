import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/Features/cart/cubit/CartState.dart';
import 'package:sahm/Features/cart/models/CartModel.dart';
import 'package:sahm/core/constant/constant.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final Dio _dio = Dio();
  CartModel? _cachedCart;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  bool get _isCacheValid =>
      _cachedCart != null &&
      _lastFetchTime != null &&
      DateTime.now().difference(_lastFetchTime!) < _cacheValidDuration;

  Future<void> loadCart({bool forceRefresh = false}) async {
    if (!forceRefresh && _isCacheValid) {
      emit(CartLoaded(_cachedCart!));
      return;
    }

    if (state is CartLoading) return;

    emit(CartLoading());
    try {
      final cartResponse = await _dio.get(
        'https://sahm-backend.onrender.com/api/cart',
        options: Options(headers: {
          'Authorization': 'Bearer ${AppStrings.token}',
        }),
      );

      if (cartResponse.statusCode == 200) {
        final cartModel = CartModel.fromJson(cartResponse.data);
        await _fetchProductDetails(cartModel);
        _cacheCart(cartModel);
        emit(CartLoaded(cartModel));
        // Log event when cart is loaded
        FirebaseAnalytics.instance.logEvent(
          name: 'cart_loaded',
          parameters: {'item_count': cartModel.cartItems?.length ?? 0},
        );
      } else {
        emit(CartError('Failed to load cart items'));
      }
    } catch (e) {
      emit(CartError('Error: $e'));
    }
  }

  Future<void> _fetchProductDetails(CartModel cartModel) async {
    for (var cartItem in cartModel.cartItems ?? []) {
      try {
        final productResponse = await _dio.get(
          'https://sahm-backend.onrender.com/api/product/${cartItem.product}',
        );

        if (productResponse.statusCode == 200) {
          final productData = productResponse.data['data'];
          cartItem.productDetails = ProductModel.fromJson(productData);
        } else {
          print(
              'Failed to load product details for product ${cartItem.product}');
        }
      } catch (e) {
        print('Error fetching product details: $e');
      }
    }
  }

  void _cacheCart(CartModel cart) {
    _cachedCart = cart;
    _lastFetchTime = DateTime.now();
  }

  Future<void> removeCartItem(String cartItemId) async {
    if (state is! CartLoaded) return;

    final currentCart = (state as CartLoaded).cartModel;
    final updatedCart = CartModel(
      cartItems: currentCart.cartItems!
          .where((item) => item.id != cartItemId)
          .toList(),
    );

    emit(CartLoaded(updatedCart));
    _cacheCart(updatedCart);

    try {
      final response = await _dio.delete(
        'https://sahm-backend.onrender.com/api/cart/$cartItemId',
        options: Options(headers: {
          'Authorization': 'Bearer ${AppStrings.token}',
        }),
      );

      if (response.statusCode != 200) {
        // If the server request fails, revert the change
        emit(CartLoaded(currentCart));
        _cacheCart(currentCart);
        emit(CartError('Failed to remove item from cart'));
      } else {
        // Log item removed event
        FirebaseAnalytics.instance.logEvent(
          name: 'cart_item_removed',
          parameters: {'cart_item_id': cartItemId},
        );
      }
    } catch (e) {
      // If there's an error, revert the change
      emit(CartLoaded(currentCart));
      _cacheCart(currentCart);
      emit(CartError('Error: $e'));
    }
  }

  void refreshCart() {
    loadCart(forceRefresh: true);
  }

  void invalidateCache() {
    _lastFetchTime = null;
  }

  Future<void> updateCartItemQuantity(
      String cartItemId, int newQuantity) async {
    if (state is! CartLoaded) return;

    final currentCart = (state as CartLoaded).cartModel;
    final updatedCart = CartModel(
      cartItems: currentCart.cartItems!.map((item) {
        if (item.id == cartItemId) {
          return CartItemm(
            id: item.id,
            product: item.product,
            quantity: newQuantity,
            price: item.price,
            productDetails: item.productDetails,
          );
        }
        return item;
      }).toList(),
    );

    emit(CartLoaded(updatedCart));
    _cacheCart(updatedCart);

    try {
      final response = await _dio.put(
        'https://sahm-backend.onrender.com/api/cart/$cartItemId',
        data: {'quantity': newQuantity},
        options: Options(headers: {
          'Authorization': 'Bearer ${AppStrings.token}',
        }),
      );

      if (response.statusCode != 200) {
        // If the server request fails, revert the change
        emit(CartLoaded(currentCart));
        _cacheCart(currentCart);
        emit(CartError('Failed to update item quantity'));
      } else {
        // Log quantity update event
        FirebaseAnalytics.instance.logEvent(
          name: 'cart_item_quantity_updated',
          parameters: {
            'cart_item_id': cartItemId,
            'new_quantity': newQuantity,
          },
        );
      }
    } catch (e) {
      // If there's an error, revert the change
      emit(CartLoaded(currentCart));
      _cacheCart(currentCart);
      emit(CartError('Error: $e'));
    }
  }
}
