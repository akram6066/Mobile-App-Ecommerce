// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/bottomnavigate_provider.dart';

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search'),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   icon: Icon(Icons.search, color: Colors.grey),
//                   border: InputBorder.none,
//                   hintText: 'Search',
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.eco, size: 100, color: Colors.grey[300]),
//                     const SizedBox(height: 16),
//                     Text(
//                       "You haven't searched for items yet. Let's start now - we'll help you.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey[500]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_app/provider/bottomnavigate_provider.dart';
import 'package:test_app/provider/search%20provider.dart';
import 'package:test_app/provider/search_provider.dart'; // Adjust the import to match your folder structure
import 'package:test_app/config/constant.dart';
import 'package:test_app/widgets/bottomnavigation.dart';
import 'details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.getDataFromAPI();
    _searchController.addListener(() {
      searchProvider.search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: searchProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : searchProvider.error.isNotEmpty
                      ? Center(child: Text('Error: ${searchProvider.error}'))
                      : searchProvider.searchedProducts.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.eco,
                                      size: 100, color: Colors.grey[300]),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No search results found. Try a different query.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: searchProvider.searchedProducts.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: MediaQuery.of(context).size.width < 600 ? 20 : 18,
                                mainAxisSpacing: 18,
                                mainAxisExtent: 200,
                              ),
                              itemBuilder: (ctx, index) {
                                final product = searchProvider.searchedProducts[index];

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
                                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => const Icon(Icons.error_outline),
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
                                                product.name??"",
                                                style: const TextStyle(color: Colors.black, fontSize: 14),
                                              ),
                                              Text("\$${product.salePrice}"),
                                              const SizedBox(height: 5),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // Add to cart logic
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
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
            ),
          ],
        ),
        
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
