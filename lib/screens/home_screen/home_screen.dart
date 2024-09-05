import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/screens/create_bill_screen/create_bill_screen.dart';
import 'package:contri_buter/screens/home_screen/widgets/appbar_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/filter_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/info_widget.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedGroup = 'All'; // Manage selected group state
  late final UserProvider userProvider;
  late List<TransactionModel> transactions;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    transactions = userProvider.transactions;
  }

  @override
  void didChangeDependencies() async {
    await userProvider.fetchTransactions();
    transactions = userProvider.transactions;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),

        child: Icon(
          Icons.add,
          color: AppColors.white,
          size: 30,
        ),
        backgroundColor: AppColors.kDarkColor,
        onPressed: () {
          logEvent(str: 'Pressed');
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBillScreen(),));
        },
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
            InfoWidget(
                selectedGroup: _selectedGroup,
                transactions:
                    transactions), // Pass transactions and selected group
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
                transactions: transactions,
                selectedGroup: _selectedGroup,
                onGroupSelected: (group) {
                  setState(() {
                    _selectedGroup = group; // Update selected group
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
