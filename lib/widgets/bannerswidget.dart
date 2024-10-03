// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_app/config/constant.dart';
// import 'package:test_app/provider/banner_provider.dart';
// import 'package:shimmer/shimmer.dart'; // Import shimmer

// class BannersWidget extends StatelessWidget {
//   const BannersWidget({
//     super.key,
//     required this.screenWidth,
//     required this.currentIndex, required int currentindex, required List imageUrls,
//   });

//   final double screenWidth;
//   final int currentIndex;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Provider.of<BannerProvider>(context, listen: false).fetchBanners(),
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: screenWidth,
//                 height: 120,
//                 color: Colors.white,
//               ),
//             ),
//           );
//         } else {
//           if (snapshot.error != null) {
//             return const Center(child: Text('An error occurred!'));
//           } else {
//             return Consumer<BannerProvider>(
//               builder: (ctx, bannerProvider, child) {
//                 final banners = bannerProvider.banners;
//                 if (banners.isEmpty) {
//                   return const Center(child: Text('No banners found.'));
//                 }
//                 final imageUrls = banners.expand((banner) => banner.images!).toList();
//                 return Stack(
//                   children: [
//                     SizedBox(
//                       width: screenWidth,
//                       height: 120,
//                       child: CarouselSlider.builder(
//                         itemCount: imageUrls.length,
//                         options: CarouselOptions(
//                           viewportFraction: 1.0,
//                           initialPage: 0,
//                           enableInfiniteScroll: true,
//                           autoPlay: true,
//                           enlargeCenterPage: false,
//                           scrollDirection: Axis.horizontal,
//                           onPageChanged: (index, reason) {
//                             bannerProvider.setCurrentIndex(index);
//                           },
//                         ),
//                         itemBuilder: (context, index, realIndex) => Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 26),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: CachedNetworkImage(
//                               width: screenWidth,
//                               imageUrl: "$kEndpoint/${imageUrls[index]}",
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) => Center(
//                                 child: Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Container(
//                                     width: screenWidth,
//                                     height: 120,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) => const Icon(Icons.error),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 5,
//                       left: 0,
//                       right: 0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: imageUrls
//                             .asMap()
//                             .entries
//                             .map((entry) => Container(
//                                   width: 9.0,
//                                   height: 9.0,
//                                   margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: bannerProvider.currentIndex == entry.key
//                                         ? Colors.blue
//                                         : Colors.black,
//                                   ),
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         }
//       },
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/provider/banner_provider.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer

class BannersWidget extends StatelessWidget {
  const BannersWidget({
    super.key,
    required this.screenWidth,
    required this.currentIndex, required int currentindex, required List imageUrls,
  });

  final double screenWidth;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    // Move fetchBanners call to an initState or similar.
    // Using Future.delayed to ensure it doesn't run during build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BannerProvider>(context, listen: false).fetchBanners();
    });

    return Consumer<BannerProvider>(
      builder: (ctx, bannerProvider, child) {
        if (!bannerProvider.isDataLoaded) {
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: screenWidth,
                height: 120,
                color: Colors.white,
              ),
            ),
          );
        } else if (bannerProvider.banners.isEmpty) {
          return const Center(child: Text('No banners found.'));
        } else {
          final imageUrls = bannerProvider.banners.expand((banner) => banner.images!).toList();
          return Stack(
            children: [
              SizedBox(
                width: screenWidth,
                height: 120,
                child: CarouselSlider.builder(
                  itemCount: imageUrls.length,
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      bannerProvider.setCurrentIndex(index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        width: screenWidth,
                        imageUrl: "$kEndpoint/${imageUrls[index]}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: screenWidth,
                              height: 120,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageUrls
                      .asMap()
                      .entries
                      .map((entry) => Container(
                            width: 9.0,
                            height: 9.0,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: bannerProvider.currentIndex == entry.key
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
