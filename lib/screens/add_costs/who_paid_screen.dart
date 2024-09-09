// import 'package:contri_buter/constants/UI.dart';
// import 'package:contri_buter/models/contacts.dart';
// import 'package:contri_buter/screens/create_bill_screen/widgets/contact_avatar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:contri_buter/providers/split_provider.dart';

// class SelectedContactsScreen extends StatelessWidget {
//   const SelectedContactsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(CupertinoIcons.back),
//         ),
//         title: Text(
//           'Who Paid?',
//           style: AppTextStyles.kCreateBillAppBarTitleTextStyle,
//         ),
//         forceMaterialTransparency: true,
//       ),
//       body: Padding(
//         padding: AppPaddings.scaffoldPadding,
//         child: Consumer<SplitProvider>(
//           builder: (context, splitProvider, child) {
//             double totalBillAmount = double.parse(splitProvider.billAmount);
//             double totalContributed = 0;

//             return ListView.builder(
//               itemCount: splitProvider.selectedContacts.length,
//               itemBuilder: (context, index) {
//                 final contact = splitProvider.selectedContacts[index];
//                 return ListTile(
//                   leading: ContactCircleAvatar(contact: contact),
//                   title: Text(
//                     contact.name,
//                     style: AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 13.sp),
//                   ),
//                   subtitle: Text(
//                     contact.phNo,
//                     style: AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500),
//                   ),
//                   trailing: SizedBox(
//                     width: 80,
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         hintText: 'Share',
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//                       ),
//                       style: TextStyle(fontSize: 12.sp),
//                       onChanged: (value) {
//                         double contribution = double.tryParse(value) ?? 0;
//                         totalContributed = splitProvider.selectedContacts.fold(
//                           0,
//                           (sum, contact) => sum + (double.tryParse(contact.contribution ?? '0') ?? 0),
//                         );
//                         if (totalContributed > totalBillAmount) {
//                           // Reset the input if total exceeds bill amount
//                           splitProvider.updateContactContribution(contact, '');
//                         } else {
//                           splitProvider.updateContactContribution(contact, value);
//                         }
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }