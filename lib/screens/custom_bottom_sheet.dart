import 'dart:io';

import 'package:codelandia_firestore/constants/colors.dart';
import 'package:flutter/material.dart';

import '../data/models/product_model/product_model.dart';
import '../data/service/firestore_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  File? _selectedImage;
  String? imageUrl;

  Future<void> imagePicker() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      imageQuality: 50,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    final firebaseStorage = FirebaseStorage.instance;
    final imageUpload = firebaseStorage
        .ref()
        .child('products_images')
        .child('${DateTime.now().toIso8601String()}.jpg');
    await imageUpload.putFile(_selectedImage!);

    imageUrl = await imageUpload.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Add Product',
                filled: true,
                fillColor: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: AppColors.primaryColor.withOpacity(0.5),
            height: MediaQuery.sizeOf(context).height * 0.25,
            width: MediaQuery.sizeOf(context).width,
            child: _selectedImage == null
                ? IconButton(
                    onPressed: imagePicker,
                    icon: const Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                    ),
                  )
                : Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              if (textController.text.trim().isEmpty ||
                  _selectedImage == null ||
                  imageUrl == null) {
                setState(() {
                  isLoading = false;
                });
                return;
              }

              InitFireStore.uploadData(
                ProductModel(
                  name: textController.text,
                  purchased: false,
                  imageUrl: imageUrl!,
                ),
              );

              textController.clear();

              Navigator.pop(context);
            },
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
