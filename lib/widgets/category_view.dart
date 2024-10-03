import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/Model/category_model.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/category_provider.dart';
import 'package:test_app/screens/product_screen.dart';

class CategoryView extends StatelessWidget {
  final double screenHeight;
  final double mainAxisExtent;
  final double screenWidth;

  const CategoryView({
    super.key,
    required this.screenHeight,
    required this.mainAxisExtent,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return FutureBuilder(
      future: categoryProvider.loadCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 8,  // Adjust this count to show more shimmer items if necessary
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.75,
              crossAxisSpacing: screenWidth < 600 ? 10 : 16,
              mainAxisExtent: screenWidth * 0.33,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Consumer<CategoryProvider>(
            builder: (context, categoryProvider, _) {
              if (!categoryProvider.categoriesLoaded) {
                return const Center(child: Text('No categories found.'));
              }

              return Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.6, color: kPrimarycolor),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: categoryProvider.categories.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: screenWidth < 600 ? 10 : 16,
                    mainAxisExtent: screenWidth * 0.33,
                  ),
                  itemBuilder: (context, categoryIndex) {
                    CategoryModel category =
                        categoryProvider.categories[categoryIndex];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductScreen(categoryId: category.id!),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenWidth * 0.18,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: screenWidth * 0.2,
                                    decoration: BoxDecoration(
                                      color: kPrimarycolor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  if (category.photos != null &&
                                      category.photos!.isNotEmpty)
                                    Container(
                                      height: screenWidth * 0.14,
                                      width: screenWidth * 0.14,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE7E7E7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "$kEndpoint/${category.photos![0]}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.white,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error_outline),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              category.name ?? "",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              category.description ?? "",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
