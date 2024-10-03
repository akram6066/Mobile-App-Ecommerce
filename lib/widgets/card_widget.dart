import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/cartprovider.dart';
import 'package:test_app/provider/product_provider.dart';
import 'package:test_app/screens/details.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.imgUrl,
    required List products,
  }) : super(key: key);

  final List<String> imgUrl;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    // Fetch trending products if not already loaded
    if (!productProvider.isTrendingLoaded) {
      productProvider.fetchTrendingProducts();
    }

    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;

      return Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) {
          if (!productProvider.isTrendingLoaded) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 6,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 600 ? 2 : 4,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: screenWidth < 600 ? 20 : 16,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 190,
                ),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(2, 4),
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          } else if (productProvider.trendingProducts.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: double.infinity,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: productProvider.trendingProducts.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 600 ? 2 : 4,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: screenWidth < 600 ? 20 : 16,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 190,
                ),
                itemBuilder: (context, index) {
                  final product = productProvider.trendingProducts[index];
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
                          ),
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
                                imageUrl: product.images.isNotEmpty
                                  ? "$kEndpoint/${product.images[0]}"
                                  : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                  const Icon(Icons.error_outline),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text('\$${product.price}'),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      cartProvider.addItem(
                                        product.id??"",
                                        product.name??"",
                                        product.salePrice??14,
                                        "$kEndpoint/${product.images[0]}",
                                      );
                                      ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            content: Text('${product.name} added to cart!'),
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 10, right: 5),
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: kPrimarycolor,
                                        borderRadius: BorderRadius.circular(50),
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
              ),
            );
          }
        },
      );
    });
  }
}
