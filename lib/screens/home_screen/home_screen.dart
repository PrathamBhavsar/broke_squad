import 'package:contri_buter/controllers/firebase_controller.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/screens/create_bill_screen/create_bill_screen.dart';
import 'package:contri_buter/screens/home_screen/widgets/appbar_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/filter_widget.dart';
import 'package:contri_buter/screens/home_screen/widgets/info_widget.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedGroup = 'All'; // Manage selected group state
  late Future<void> _userFuture;
  late Future<List<TransactionModel>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future to fetch user data
    _userFuture = UserProvider.instance.getUser();
    // Initialize the future to fetch transactions
    _transactionsFuture = _fetchTransactions();
  }

  Future<List<TransactionModel>> _fetchTransactions() async {
    // Fetch transactions from Firebase
    return FirebaseController.instance.getTransactions();
  }

  Future<void> _refreshTransactions() async {
    // Refresh transactions by fetching them again
    setState(() {
      _transactionsFuture = _fetchTransactions();
    });
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateBillScreen(),
              ));
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FutureBuilder<void>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Icon(Icons.error);
            } else {
              return AppbarWidget();
            }
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTransactions, // Set the refresh callback
        child: Padding(
          padding: AppPaddings.scaffoldPadding,
          child: FutureBuilder<List<TransactionModel>>(
            future: _transactionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(), // Show loading indicator
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching transactions'),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final transactions = snapshot.data!;

                return Column(
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
                );
              } else {
                return Center(
                  child: Text('No transactions available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
