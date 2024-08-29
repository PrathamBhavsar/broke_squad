import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/constants/routes.dart';
import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:contri_buter/screens/add_costs/add_costs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCostsButton extends StatelessWidget {
  const AddCostsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCostsScreen(),));
        },

       child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Costs',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),

           ),
     );
  }
}
