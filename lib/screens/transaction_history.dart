// // import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:test_app/provider/order_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:test_app/Model/orders_model.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class OrderHistoryScreen extends StatelessWidget {
//    final List<Map<String, dynamic>> orderItems;
//    final String userId;

//   const OrderHistoryScreen({super.key, required this.orderItems, required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = Provider.of<OrderProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order History'),
//       ),
//       body: FutureBuilder<List<OrderModel>>(
//         future: orderProvider.addOrder(orderData, widget.userId), // Fetch orders
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final orders = snapshot.data!;
//             return AnimationLimiter(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 10.0,
//                 ),
//                 itemCount: orders.length,
//                 itemBuilder: (context, index) {
//                   final order = orders[index];
//                   return AnimationConfiguration.staggeredGrid(
//                     position: index,
//                     duration: const Duration(milliseconds: 375),
//                     columnCount: 2,
//                     child: ScaleAnimation(
//                       child: GestureDetector(
//                         onTap: () {
//                           // Implement view order action
//                         },
//                         child: Card(
//                           elevation: 5.0,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Display product image
//                               Image.network(
//                                 order.productImage,
//                                 height: 120,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Display product name
//                                     Text(
//                                       order.productName,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     // Display delivery status
//                                     Text(
//                                       'Delivery: ${order.deliveryStatus}',
//                                     ),
//                                     SizedBox(height: 4),
//                                     // Display final total
//                                     Text(
//                                       'Total: \$${order.finalTotal.toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
