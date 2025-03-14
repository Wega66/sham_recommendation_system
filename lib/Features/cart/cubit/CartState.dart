import 'package:equatable/equatable.dart';
import 'package:sahm/Features/cart/models/CartModel.dart';


abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

// Initial state when the cart is not loaded yet
class CartInitial extends CartState {}

// Loading state when cart items are being fetched
class CartLoading extends CartState {}

// Error state in case something goes wrong while fetching the cart
class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

// Loaded state when the cart is successfully fetched
class CartLoaded extends CartState {
  final CartModel cartModel;

  const CartLoaded(this.cartModel);

  @override
  List<Object?> get props => [cartModel];
}
