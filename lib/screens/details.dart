import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Model/product_model.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/cartprovider.dart';
import 'package:test_app/provider/product_provider.dart';
import 'package:test_app/screens/cart_screen.dart';

class Details extends StatefulWidget {
  final Product product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Product currentProduct;

  @override
  void initState() {
    super.initState();
    currentProduct = widget.product;
    print('Initial product: ${currentProduct.name}');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width,
              height: 360,
              color: const Color(0xffE9E9E9),
              child: CachedNetworkImage(
                imageUrl: "$kEndpoint/${currentProduct.images[0]}",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
                fit: BoxFit.fill,
              ),
            ),
            FutureBuilder<List<Product>>(
              future:
                  productProvider.fetchSimilarProducts(currentProduct.catID??""),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No similar products found.'));
                } else {
                  final similarProducts = snapshot.data!.take(3).toList();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 200,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: similarProducts.length,
                        itemBuilder: (context, index) {
                          final similarProduct = similarProducts[index];
                          return GestureDetector(
                            onTap: () {
                              productProvider
                                  .fetchSimilarProducts(similarProduct.catID??"");
                              setState(() {
                                currentProduct = similarProduct;
                                print(
                                    'Product changed to: ${currentProduct.name}');
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "$kEndpoint/${similarProduct.images[0]}",
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error_outline),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                currentProduct.name??"",
                style: AppTheme.kbigtitle
                    .copyWith(color: kPrimarycolor, fontSize: 16),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "\$${currentProduct.salePrice}",
                style: AppTheme.kbigtitle
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Description",
                style: AppTheme.kbigtitle
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                currentProduct.description??"",
                style: AppTheme.kbodyfonts.copyWith(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ),
            const Gap(30),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.87,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    final cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    cartProvider.addItem(
                      currentProduct.id!,
                      currentProduct.name!,
                      currentProduct.salePrice!,
                      "$kEndpoint/${currentProduct.images[0]}",
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${currentProduct.name} added to cart!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    "Add to Cart",
                    style: AppTheme.kbodyfonts.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
