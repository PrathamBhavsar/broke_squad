import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/screens/home_screen/widgets/add_costs_button.dart';
import 'package:contri_buter/screens/home_screen/widgets/appbar_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

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

              title: Row(children: [
                IconButton(
                  icon: Icon(Icons.notifications_none_rounded),
                  onPressed: () {},
                ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.white,
                ),
              ),
            )
              ],),
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
