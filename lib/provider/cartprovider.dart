// import 'package:flutter/material.dart';
// import 'package:test_app/Model/cart_model.dart';

// class CartProvider with ChangeNotifier {
//   Map<String, CartItem> _items = {};
//   final double _deliveryFee = 5.0; // Fixed delivery fee

//   Map<String, CartItem> get items => _items;

//   int get itemCount => _items.length;

//   double get totalAmount {
//     double total = 0.0;
//     _items.forEach((key, cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });
//     return total;
//   }

//   double get deliveryFee => _deliveryFee;

//   double get finalTotal => totalAmount + deliveryFee;

//   void addItem(String productId, String name, double price, String imageUrl) {
//     if (_items.containsKey(productId)) {
//       _items.update(
//         productId,
//         (existingCartItem) => CartItem(
//           id: existingCartItem.id,
//           name: existingCartItem.name,
//           price: existingCartItem.price,
//           imageUrl: existingCartItem.imageUrl,
//           quantity: existingCartItem.quantity + 1,
//         ),
//       );
//     } else {
//       _items.putIfAbsent(
//         productId,
//         () => CartItem(
//           id: productId,
//           name: name,
//           price: price,
//           imageUrl: imageUrl,
//           quantity: 1,
//         ),
//       );
//     }
//     notifyListeners();
//   }

//   void removeItem(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }

//   void increaseQuantity(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.update(
//         productId,
//         (existingCartItem) => CartItem(
//           id: existingCartItem.id,
//           name: existingCartItem.name,
//           price: existingCartItem.price,
//           imageUrl: existingCartItem.imageUrl,
//           quantity: existingCartItem.quantity + 1,
//         ),
//       );
//     }
//     notifyListeners();
//   }

//   void decreaseQuantity(String productId) {
//     if (_items.containsKey(productId) && _items[productId]!.quantity > 1) {
//       _items.update(
//         productId,
//         (existingCartItem) => CartItem(
//           id: existingCartItem.id,
//           name: existingCartItem.name,
//           price: existingCartItem.price,
//           imageUrl: existingCartItem.imageUrl,
//           quantity: existingCartItem.quantity - 1,
//         ),
//       );
//     } else {
//       _items.remove(productId);
//     }
//     notifyListeners();
//   }

//   void clearCart() {
//     _items = {};
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:test_app/Model/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  final double _deliveryFee = 0.0; // Fixed delivery fee

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  double get deliveryFee => _deliveryFee;

  double get finalTotal => totalAmount + deliveryFee;

  List<Map<String, dynamic>> get orderItems {
    return _items.entries.map((entry) {
      return {
        'product': entry.key,
        'quantity': entry.value.quantity,
      };
    }).toList();
  }

  void addItem(String productId, String name, double price, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          name: name,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    }
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId) && _items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
