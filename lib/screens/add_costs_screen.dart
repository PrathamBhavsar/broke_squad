import 'package:contri_buter/constants/routes.dart';
import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/screens/home_screen/widgets/add_costs_button.dart';
import 'package:contri_buter/screens/home_screen/widgets/appbar_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddCostsScreen extends StatefulWidget {
  const AddCostsScreen({super.key});

  @override
  State<AddCostsScreen> createState() => _AddCostsScreenState();
}

class _AddCostsScreenState extends State<AddCostsScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Provider.of<NavigationProvider>(context, listen: false)
                    .pop(context);
              },
              icon: Icon(Icons.close_rounded)),
        ),
        body: Padding(
          padding: AppPaddings.scaffoldPadding,
          child: Column(
            children: [
              InfoWidget(),
              SizedBox(height: 10),
              // Add any additional widgets here
              Expanded(
                child: Container(
                    // This container will take up the remaining space
                    ),
              ),
              SizedBox(height: 10),
              AddCostsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
