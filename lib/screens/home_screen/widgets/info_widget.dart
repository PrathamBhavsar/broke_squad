import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/cupertino.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
          Align(
            alignment: Alignment.centerLeft,

            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You're owed", style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600 ),),
                  Text("0.00", style: TextStyle(fontSize: 28,fontWeight:FontWeight.w600 ),),
                ],
              ),
            ),
          ),

        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 150,
              width: (MediaQuery.of(context).size.width - 34) / 2,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:                     Align(
                alignment: Alignment.centerLeft,

                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("My costs", style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600 ),),
                      Text("0.00", style: TextStyle(fontSize: 28,fontWeight:FontWeight.w600 ),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 150,
              width: (MediaQuery.of(context).size.width - 34) / 2,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.accentColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child:                     Align(
                alignment: Alignment.centerLeft,

                child: Padding(
                  padding: const EdgeInsets.all(23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total costs", style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600 ),),
                      Text("0.00", style: TextStyle(fontSize: 28,fontWeight:FontWeight.w600 ),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
