import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahm/Features/cart/cubit/CartCubit.dart';
import 'package:sahm/Features/cart/models/CartModel.dart';

Widget buildCartItem(CartItemm item, BuildContext context) {
  final product = item.productDetails;
  final cartCubit = BlocProvider.of<CartCubit>(context);

  return Card(
    margin: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 100,
          color: Colors.white,
          child: Image.network(
            product!.imageCover!,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          product.title!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text('Color: red'),
                          const SizedBox(width: 5),
                          Text('Size:'),
                        ],
                      ),
                    ],
                  ),
                PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (String result) {
                      switch (result) {
                        case 'favorite':
                          // Implement add to favorite functionality
                          break;
                        case 'delete':
                          cartCubit.removeCartItem(item.id!);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'favorite',
                        child: Text('Add to Favorite'),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete from the list'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (item.quantity! > 1) {
                          cartCubit.updateCartItemQuantity(
                              item.id!, item.quantity! - 1);
                        }
                      },
                      icon: const Icon(Icons.remove, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${item.quantity}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        cartCubit.updateCartItemQuantity(
                            item.id!, item.quantity! + 1);
                      },
                      icon: const Icon(Icons.add, size: 20),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text('\$${product.price}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
