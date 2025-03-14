import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/Features/cart/cubit/CartCubit.dart';
import 'package:sahm/Features/cart/cubit/CartState.dart';

Widget buildTotalAmount() {
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      if (state is CartLoaded) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total amount:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$${state.cartModel.totalCartPrice}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }
      return SizedBox
          .shrink(); // Return an empty widget if state is not CartLoaded
    },
  );
}
