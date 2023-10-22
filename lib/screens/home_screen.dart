import 'package:codelandia_firestore/constants/colors.dart';
import 'package:codelandia_firestore/data/service/firestore_service.dart';
import 'package:codelandia_firestore/providers/stream_riverpod.dart';
import 'package:codelandia_firestore/screens/custom_bottom_sheet.dart';
import 'package:codelandia_firestore/screens/widgets/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/product_model/product_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productData = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Codelandia Firestore'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const CustomBottomSheet(),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const WelcomeWidget(),
            const SizedBox(height: 10),
            Expanded(
              child: productData.when(
                data: (data) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final ProductModel productModel = data[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        InitFireStore.deleteData(productModel.id!);
                      },
                      key: UniqueKey(),
                      child: Card(
                        child: ListTile(
                          /// Click to open image
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: const Text('Product Image'),
                                  content: Image.network(productModel.imageUrl),
                                  actions: [
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(productModel.imageUrl),
                          ),
                          title: Text(productModel.name),
                          trailing: IconButton(
                            onPressed: () {
                              InitFireStore.updateData(
                                productModel.copyWith(
                                  purchased: !productModel.purchased,
                                ),
                                productModel.id!,
                              );
                            },
                            icon: data[index].purchased
                                ? const Icon(
                                    Icons.check_box_outlined,
                                    color: AppColors.primaryColor,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: AppColors.primaryColor,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                error: (error, stackTrace) => Center(
                  child: Text('Error:$error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
