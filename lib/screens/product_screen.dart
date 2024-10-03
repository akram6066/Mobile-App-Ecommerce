import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:test_app/config/constant.dart';
import 'package:test_app/provider/cartprovider.dart';
import 'package:test_app/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/screens/details.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;

  const ProductScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProductsByCategory(widget.categoryId);
    });
  }

  // Example of calling clearAndRefetchSimilarProducts



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: cartProvider.itemCount > 0
                  ? badges.Badge(
                      badgeContent: Text(
                        cartProvider.itemCount.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        padding: EdgeInsets.all(5),
                      ),
                      position: badges.BadgePosition.topEnd(top: 5, end: 5),
                      child: const Icon(
                        IconlyBold.bag_2,
                        color: kPrimarycolor,
                        size: 25,
                      ),
                    )
                  : const Icon(
                      IconlyBold.bag_2,
                      color: kPrimarycolor,
                      size: 25,
                    ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return productProvider.products.isEmpty
              ? GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 6, // Number of shimmer items to show
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 600 ? 2 : 4,
                    childAspectRatio: 0.9,
                    crossAxisSpacing:
                        MediaQuery.of(context).size.width < 600 ? 20 : 18,
                    mainAxisSpacing: 18,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (ctx, index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: productProvider.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 600 ? 2 : 4,
                    childAspectRatio: 0.9,
                    crossAxisSpacing:
                        MediaQuery.of(context).size.width < 600 ? 20 : 18,
                    mainAxisSpacing: 18,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (ctx, index) {
                    final product = productProvider.products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Details(product: product),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F5F5),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 4),
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xffE7E7E7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: "$kEndpoint/${product.images[0]}",
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error_outline),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name ?? "",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  Text("\$${product.salePrice}"),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .addItem(
                                          product.id ?? "",
                                          product.name ?? "",
                                          product.salePrice ?? 15,
                                          "$kEndpoint/${product.images[0]}",
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${product.name} added to cart!'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: kPrimarycolor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
