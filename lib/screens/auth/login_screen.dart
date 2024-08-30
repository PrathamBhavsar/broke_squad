import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/screens/auth/widgets/login_button.dart';
import 'package:contri_buter/screens/auth/widgets/textfeieds.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode phoneFocusNode = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController areaCodeController =
      TextEditingController(text: "+91"); // Default area code

  @override
  void dispose() {
    // Clean up the controllers and focus nodes when the widget is disposed
    phoneFocusNode.dispose();
    phoneController.dispose();
    areaCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss the keyboard when tapping outside
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
                        // Add your custom design for the top section here
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                // Phone number input with area code
                                Row(
                                  children: [
                                    // Area code text field
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: areaCodeController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: "Area Code",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Phone number text field
                                    Expanded(
                                      flex: 3,
                                      child: PhoneTextField(
                                        phoneFocusNode: phoneFocusNode,
                                        phoneController: phoneController,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Login button
                            LoginButton(
                              phoneController: phoneController,
                              areaCodeController: areaCodeController,
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
