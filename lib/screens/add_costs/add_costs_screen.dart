import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:contri_buter/screens/add_costs/next_button.dart';
import 'package:contri_buter/screens/add_costs/text_fields.dart';
import 'package:contri_buter/screens/home_screen/widgets/add_costs_button.dart';
import 'package:contri_buter/screens/home_screen/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contri_buter/constants/UI.dart';

class AddCostsScreen extends StatefulWidget {
  const AddCostsScreen({super.key});

  @override
  State<AddCostsScreen> createState() => _AddCostsScreenState();
}

class _AddCostsScreenState extends State<AddCostsScreen> {
  FocusNode descFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
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
              SizedBox(height: 10),
              DescriptionTextField(
                descFocusNode: descFocusNode,
                descController: descController,
              ),
              SizedBox(height: 10),
              AmountTextField(
                amountController: amountController,
                amountFocusNode: amountFocusNode,
              ),
              SizedBox(height: 10),
              DateTextField(
                dateFocusNode: dateFocusNode,
                dateController: dateController,
              ),
              Expanded(
                child: Container(
                    // This container will take up the remaining space
                    ),
              ),
              SizedBox(height: 10),
              NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
