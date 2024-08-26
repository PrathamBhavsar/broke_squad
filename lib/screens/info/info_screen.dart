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
            title: Center(child: Text('Personal Information')),
          ),
          body: SingleChildScrollView(
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
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(120)),
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
          ),
        ),
      ),
    );
  }
}
