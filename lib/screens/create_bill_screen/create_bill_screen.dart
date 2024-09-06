import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/providers/split_provider.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/avatar_indicator.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/bill_name_text_field.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/contact_avatar.dart';
import 'package:contri_buter/screens/create_bill_screen/widgets/continue_button.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CreateBillScreen extends StatefulWidget {
  const CreateBillScreen({super.key});

  @override
  State<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends State<CreateBillScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _billNameController = TextEditingController();
  final FocusNode _billNameFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    _searchController.addListener(
      () {
        SplitProvider.instance.filterContact(_searchController.text);
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Future.delayed(Duration(milliseconds: 200));
    SplitProvider.instance.getContact();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    SplitProvider.instance.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplitProvider>(
      builder: (context, splitProvider, child) {
        List<Widget> views = [_buildAddPeople(splitProvider), _buildBillData(splitProvider)];
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () => splitProvider.manageBack(context),
                icon: Icon(CupertinoIcons.back)),
            title: Text(
              splitProvider.abbBarTitles[splitProvider.currentIndex],
              style: AppTextStyles.kCreateBillAppBarTitleTextStyle,
            ),
            forceMaterialTransparency: true,
          ),
          body: Padding(
            padding: AppPaddings.scaffoldPadding,
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: getHeight(context) -
                            kBottomNavigationBarHeight -
                            kToolbarHeight -
                            24 * 3), // 24 * 3 to adjust paddings
                    child: IntrinsicHeight(child: views[splitProvider.currentIndex]))),
          ),
          bottomNavigationBar: ContinueButton(
            onPressed: () {
              if (splitProvider.currentIndex == 0) {
                splitProvider.manageContinue(context);
              } else {
                splitProvider.manageContinue(context, () {
                  if (validateBillData()) {
                    splitProvider.setBillName(_billNameController.text);
                    splitProvider.setBillAmount(_amountController.text);
                    splitProvider.billCategory.isEmpty
                        ? splitProvider.setBillCategory(categories.last.toString())
                        : null;
                  }
                });
              }
            },
          ),
        );
      },
    );
  }

  bool validateBillData() {
    if (_billNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Bill Name');
      return false;
    }
    if (_amountController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Bill Amount');
      return false;
    }
    return true;
  }

  _buildAddPeople(SplitProvider splitProvider) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Search Contact',
            style: AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 14.sp),
          ),
        ),
        spaceH10(),
        CreateBillViewTextField(
          textController: _searchController,
          focusNode: _searchFocusNode,
          hintText: 'Search...',
        ),
        spaceH10(),
        AvatarIndicator(context: context, selectedContacts: splitProvider.selectedContacts),
        spaceH20(),
        splitProvider.displayContacts.isEmpty
            ? ElevatedButton(
                onPressed: () async => await FlutterContacts.openExternalInsert().whenComplete(
                      () async => await splitProvider.getContact(),
                    ),
                child: Text(
                  'Add Contact',
                  style: AppTextStyles.poppins
                      .copyWith(color: AppColors.grey, fontWeight: FontWeight.w500),
                ))
            : Flexible(
                child: SizedBox(
                  height: getHeight(context),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: ContactCircleAvatar(contact: splitProvider.displayContacts[index]),
                        title: Text(
                          splitProvider.displayContacts[index].name,
                          style: AppTextStyles.kCreateBillAppBarTitleTextStyle
                              .copyWith(fontSize: 13.sp),
                        ),
                        subtitle: Text(splitProvider.displayContacts[index].phNo,
                            style: AppTextStyles.kCreateBillAppBarTitleTextStyle
                                .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        trailing: Checkbox(
                          value: splitProvider.selectedContacts.isNotEmpty
                              ? splitProvider.selectedContacts
                                  .contains(splitProvider.displayContacts[index])
                              : false,
                          onChanged: (value) => setState(() => value != null
                              ? (!value
                                  ? splitProvider
                                      .removeContact(splitProvider.displayContacts[index])
                                  : splitProvider.addContact(splitProvider.displayContacts[index]))
                              : null),
                          shape: CircleBorder(),
                        ),
                      );
                    },
                    itemCount: splitProvider.displayContacts.length,
                  ),
                ),
              ),
      ],
    );
  }

  _buildBillData(SplitProvider provider) {
    return Column(
      children: [
        spaceH10(),
        Stack(
          children: [
            AvatarIndicator(context: context, selectedContacts: provider.selectedContacts),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () => provider.manageBack(context),
                    shape: CircleBorder(),
                    elevation: 0,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.kPrimaryColor,
                  )),
            )
          ],
        ),
        spaceH20(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bill Name',
            style: AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 14.sp),
          ),
        ),
        CreateBillViewTextField(
          textController: _billNameController,
          focusNode: _billNameFocusNode,
          hintText: 'Enter Bill Name',
        ),
        spaceH20(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bill Amount',
            style: AppTextStyles.kCreateBillAppBarTitleTextStyle.copyWith(fontSize: 14.sp),
          ),
        ),
        CreateBillViewTextField(
          textController: _amountController,
          focusNode: _amountFocusNode,
          hintText: 'Enter Bill Amount',
          keyboardType: TextInputType.number,
        ),
        spaceH20(),
        Wrap(
          spacing: 2,
          children: [
            for (Category category in categories)
              InkWell(
                onTap: () => provider.setBillCategory(category.toString()),
                child: Chip(
                  color: WidgetStatePropertyAll(provider.billCategory == category.toString()
                      ? Colors.grey.shade400
                      : AppColors.lightGrey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      side: BorderSide(color: AppColors.grey, width: 1)),
                  label: Text(
                    "${category.emoji} ${category.text}",
                    style: AppTextStyles.poppins.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kDarkColor,
                    ),
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}

class Category {
  String text;
  String emoji;
  Category({required this.text, required this.emoji});
  @override
  String toString() => "$emoji $text";
}

List<Category> categories = [
  Category(text: 'Dinner', emoji: '🍔'),
  Category(text: 'Outing', emoji: '🎥'),
  Category(text: 'Other', emoji: '🙂'),
];
