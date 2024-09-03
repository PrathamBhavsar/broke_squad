import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/screens/home_screen/widgets/appbar_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/filter_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/demo_transactions.dart';

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
        return Scaffold(
          floatingActionButton: SizedBox(
            height: 65,
            width: 65,
            child: FloatingActionButton(
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 30,
                ),
                backgroundColor: AppColors.kDarkColor,
                onPressed: () {
                  context.goNamed('createBill');
                }),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: AppbarWidget(),
          ),
          body: Padding(
            padding: AppPaddings.scaffoldPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoWidget(),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Transactions',
                    style: AppTextStyles.kPhoneInputTextFieldTextStyle,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: TransactionFilterWidget(
                    transactions: demoTransactions,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
