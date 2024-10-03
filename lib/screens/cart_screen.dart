import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/bottomnavigate_provider.dart';
import 'package:test_app/provider/cartprovider.dart';
import 'package:test_app/provider/userProvider.dart';
import 'package:test_app/screens/home_page.dart';
import 'package:test_app/screens/order_screen.dart';
import 'package:test_app/widgets/bottomnavigation.dart';
import 'package:test_app/widgets/caritem_widget.dart';
import 'package:test_app/widgets/emptycart_widget.dart';
import '../config/themes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home_Page()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: kPrimarycolor,
        foregroundColor: kwhitecolor,
      ),
      body: cartProvider.itemCount == 0
          ? EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.itemCount,
                    itemBuilder: (ctx, i) => CartItemWidget(
                      cartProvider.items.values.toList()[i],
                      cartProvider.items.keys.toList()[i],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Items: ${cartProvider.itemCount}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Fee: \$${cartProvider.deliveryFee.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Final Total: \$${(cartProvider.finalTotal).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const Home_Page(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kwhitecolor,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: kPrimarycolor, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    foregroundColor: kPrimarycolor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                  ),
                                  child: const Text('Add Item'),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final userProvider =
                                        Provider.of<UserProvider>(context,
                                            listen: false);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => OrderScreen(
                                          orderItems: cartProvider.orderItems
                                              .map((item) => {
                                                    'product':
                                                        item['product_id'],
                                                    'quantity':
                                                        item['quantity'],
                                                    'price': item['price'],
                                                  })
                                              .toList(),
                                          userId:
                                              userProvider.currentUser?.id ??
                                                  "",
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimarycolor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    foregroundColor: kwhitecolor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                  ),
                                  child: const Text('Checkout'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Consumer<CurrentIndexProvider>(
        builder: (context, currentIndexProvider, _) {
          return BottomNavigationBarWidget(
            currentIndex: currentIndexProvider.currentIndex,
          );
        },
      ),
    );
  }
}
