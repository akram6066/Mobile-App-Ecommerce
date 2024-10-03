// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePicker extends StatefulWidget {
  
//   const ImagePicker({super.key});

//   @override
   
//   State<ImagePicker> createState() => _ImagePickerState();
// }

// class _ImagePickerState extends State<ImagePicker> {
//    File? _imageFile;

//    final ImagePicker _picker = ImagePicker();
//   File? selectimage;

//   Future getImage() async {
//     final image = await _picker.pickImage(source: ImageSource.gallery);
//     selectimage = File(image!.path);
//     setState(() {});
//   }

//   Future<void> cancelImage() async {
//     setState(() {
//       selectimage = null;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }