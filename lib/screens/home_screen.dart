import 'package:contri_buter/providers/user_provider.dart';
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none_rounded),
                    onPressed: () {},
                  ),
                  Consumer<UserProvider>(
                    builder: (context, homeProvider, child) {
                      return FutureBuilder<String?>(
                        future: homeProvider.getProfileImage(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error);
                          } else if (snapshot.hasData) {
                            final profileImageUrl = snapshot.data;
                            return profileImageUrl != null
                                ? ClipOval(
                              child: Image.network(
                                profileImageUrl,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Icon(Icons.account_circle, size: 40);
                          } else {
                            return Icon(Icons.account_circle, size: 40);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 300,
                          color: Colors.red,
                        ),
                        SizedBox(height: 10),
                        Text('HOMESCREEN'),
                        // Additional content...
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
