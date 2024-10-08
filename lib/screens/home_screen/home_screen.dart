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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<UserProvider>(context, listen: false);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        homeProvider.fetchProfileImage(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false, // Removes the back button

              title: AppbarWidget(),
            ),
            body: Padding(
              padding: AppPaddings.scaffoldPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
      },
    );
  }
}
