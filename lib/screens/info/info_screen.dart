import 'dart:io';

import 'package:contri_buter/providers/info_provider.dart';
import 'package:contri_buter/screens/info/widgets/save_button.dart';
import 'package:contri_buter/screens/info/widgets/text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  FocusNode nameFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InfoProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Personal Information'),
            ),
          ),
          body: Consumer<InfoProvider>(
            builder: (context, infoProvider, child) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: AppPaddings.scaffoldPadding,
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.camera_alt),
                                                  title: Text('Take a Photo'),
                                                  onTap: () async {
                                                    await infoProvider.pickImageFromCamera();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.photo_library),
                                                  title: Text('Choose from Gallery'),
                                                  onTap: () async {
                                                    await infoProvider.pickImageFromGallery();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(120),
                                        image: infoProvider.isPicked
                                            ? DecorationImage(
                                          image: FileImage(File(infoProvider.profileImage!)),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 15,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              NameTextField(
                                nameFocusNode: nameFocusNode,
                                nameController: nameController,
                              ),
                            ],
                          ),
                          SaveButton(nameController: nameController),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget _buildBottomSheet(BuildContext context) {
  //   return Consumer<InfoProvider>(
  //     builder: (context, infoProvider, child) {
  //       return Container(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.camera_alt),
  //               title: Text('Take a Photo'),
  //               onTap: () async {
  //                 await infoProvider.pickImageFromCamera();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Choose from Gallery'),
  //               onTap: () async {
  //                 await infoProvider.pickImageFromGallery();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
