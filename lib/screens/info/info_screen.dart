import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/providers/info_provider.dart';
import 'package:contri_buter/screens/info/widgets/save_button.dart';
import 'package:contri_buter/screens/info/widgets/text_feild.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<String> imageUrls = [];
  String selectedUrl = '';
  @override
  void didChangeDependencies() async {
    if (imageUrls.isEmpty) {
      await _getAvatars();
    }
    super.didChangeDependencies();
  }

  _getAvatars() async {
    final response = (await FirebaseFirestore.instance.collection('avatars').get()).docs;
    for (var data in response) {
      imageUrls.add(data.data()['url']);
    }
    setState(() => selectedUrl = imageUrls.first);
  }

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
              infoProvider.setImage(selectedUrl);
              return SingleChildScrollView(
                child: Padding(
                  padding: AppPaddings.scaffoldPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(selectedUrl),
                        radius: (getWidth(context) * 0.15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 18.r * 10,
                        child: GridView.count(
                          crossAxisCount: 5,
                          shrinkWrap: true,
                          crossAxisSpacing: 2.w,
                          children: [
                            for (int i = 0; i < imageUrls.length; i++)
                              InkWell(
                                onTap: () {
                                  infoProvider.setImage(imageUrls[i]);
                                  setState(
                                        () => selectedUrl = imageUrls[i],
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(imageUrls[i]),
                                  radius: 18.r,
                                ),
                              )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      NameTextField(
                        nameFocusNode: nameFocusNode,
                        nameController: nameController,
                      ),
                      SizedBox(height: 20),
                      SaveButton(nameController: nameController),
                    ],
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
