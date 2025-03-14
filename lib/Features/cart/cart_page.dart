import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sahm/Features/cart/cubit/CartCubit.dart';
import 'package:sahm/Features/cart/cubit/CartState.dart';
import 'package:sahm/Features/cart/widgets/build+total+amount.dart';
import 'package:sahm/Features/cart/widgets/build_cart_item.dart';
import 'package:sahm/Features/cart/widgets/build_checkout_button.dart';
import 'package:sahm/Features/cart/widgets/build_promo_code_input.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit()..loadCart(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: _buildAppBar(),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return _buildLoadingView();
            } else if (state is CartError) {
              return _buildErrorView(state.message);
            } else if (state is CartLoaded) {
              return _buildLoadedView(context, state);
            }
            return Container();
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'My Cart',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Implement search functionality
          },
        ),
      ],
    );
  }

  Widget _buildLoadingView() {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          size: 50,
          color: Colors.red,
        )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
            .scale(duration: 600.ms, curve: Curves.easeOutBack)
            .move(
              begin: Offset(0, -20),
              delay: 100.ms,
              duration: 600.ms,
              curve: Curves.easeInOut,
            )
            .then(),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(child: Text(message));
  }

  Widget _buildLoadedView(BuildContext context, CartLoaded state) {
    final cartItems = state.cartModel.cartItems ?? [];

    // Update total amount
  

    if (cartItems.isEmpty) {
      return _buildEmptyCartView();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CartCubit>().refreshCart();
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return buildCartItem(cartItems[index], context)
                    .animate()
                    .slideY();
              },
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'Cart is Empty',
              speed: Duration(milliseconds: 250),
            ),
          ],
          repeatForever: true,
          isRepeatingAnimation: true,
         
        ),
      ).animate().fadeIn().scale().move(delay: 20.ms, duration: 600.ms),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        buildPromoCodeInput().animate().slideY(), 
        buildTotalAmount() ,
        Builder(
          builder: (context) => buildCheckoutButton(context).animate().slideY(),
        ),
      ],
    );
  }
}
