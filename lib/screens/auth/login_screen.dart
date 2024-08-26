import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/login_provider.dart';
import 'package:contri_buter/screens/auth/widgets/login_button.dart';
import 'package:contri_buter/screens/auth/widgets/textfeieds.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                EmailTextField(
                                  emailFocusNode: emailFocusNode,
                                  emailController: emailController,
                                ),
                                SizedBox(height: 10),
                                PasswordTextField(
                                  passwordFocusNode: passwordFocusNode,
                                  passwordController: passwordController,
                                ),
                              ],
                            ),
                            loginButton(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          ],
                        ),
                      ),
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
