import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/models/contacts.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/avatar_indicator.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/bill_name_text_field.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/contact_avatar.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/continue_button.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBillScreen extends StatefulWidget {
  const CreateBillScreen({super.key});

  @override
  State<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends State<CreateBillScreen> {
  final TextEditingController _billNameController = TextEditingController();
  final FocusNode _billNameFocusNode = FocusNode();
  final List<Contact> _selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading:
            IconButton(onPressed: () => Navigator.pop(context), icon: Icon(CupertinoIcons.back)),
        title: Text(
          'Create new split bill',
          style: AppTextStyles.kCreateBillAppBarTitleTextStyle,
        ),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: AppPaddings.scaffoldPadding,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Search Contact',
                style: AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 14.sp),
              ),
            ),
            spaceH10(),
            CreateBillTextField(
                billNameController: _billNameController, billNameFocusNode: _billNameFocusNode,hintText: 'Search...',),
            spaceH10(),
            AvatarIndicator(context: context, selectedContacts: _selectedContacts),
            spaceH20(),
            Flexible(
              child: SizedBox(
                height: getHeight(context),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ContactCircleAvatar(contact: contactsList[index]),
                      title: Text(
                        contactsList[index].name,
                        style:
                            AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 13.sp),
                      ),
                      subtitle: Text(contactsList[index].phNo,
                          style: AppTextStyles.kCreateBillAppBarTitleTextStyle
                              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                      trailing: Checkbox(
                        value: _selectedContacts.isNotEmpty
                            ? _selectedContacts.contains(contactsList[index])
                            : false,
                        onChanged: (value) => setState(() => value != null
                            ? (!value
                                ? _selectedContacts.remove(contactsList[index])
                                : _selectedContacts.add(contactsList[index]))
                            : null),
                        shape: CircleBorder(),
                      ),
                    );
                  },
                  itemCount: contactsList.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ContinueButton(onPressed: (){},),
    );
  }

}

List<Contact> contactsList = [
  Contact(name: "Alice Johnson", phNo: "+91 1234567890"),
  Contact(name: "Bob Smith", phNo: "+91 9876543210"),
  Contact(name: "Charlie Brown", phNo: "+91 7890123456"),
  Contact(name: "David Lee", phNo: "+91 6789012345"),
  Contact(name: "Emily Taylor", phNo: "+91 5678901234"),
  Contact(name: "Frank Wilson", phNo: "+91 4567890123"),
  Contact(name: "Grace Williams", phNo: "+91 3456789012"),
  Contact(name: "Henry Baker", phNo: "+91 2345678901"),
  Contact(name: "Isabella Clark", phNo: "+91 1234567890"),
  Contact(name: "Jack Brown", phNo: "+91 9876543210"),
];
