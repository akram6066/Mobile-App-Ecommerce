import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Model/cart_model.dart';

import '../provider/cartprovider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final String productId;

  const CartItemWidget(this.cartItem, this.productId, {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cart.removeItem(productId);
              },
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(cartItem.imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartItem.name),
                    Text(
                      'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        cart.decreaseQuantity(productId);
                      }
                    },
                  ),
                  Text('${cartItem.quantity} x'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cart.increaseQuantity(productId);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
