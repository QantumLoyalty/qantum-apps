import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppLogo.dart';
import 'EditUserInfo/EditDetailScreen.dart';
import 'EditUserInfo/EditMailScreen.dart';
import 'EditUserInfo/EditPhoneScreen.dart';
import 'EditUserInfo/EditUserHomeScreen.dart';

class EditUserDetailsScreen extends StatefulWidget {
  const EditUserDetailsScreen({super.key});

  @override
  State<EditUserDetailsScreen> createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  var screens = [
    const EditUserHomeScreen(),
    const EditDetailScreen(),
    const EditMailScreen(),
    const EditPhoneScreen()
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<UserInfoProvider>(context, listen: false)
        .updateSelectedEditScreen(UserInfoProvider.EDIT_SCREEN);
    Provider.of<UserInfoProvider>(context, listen: false).initTempUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child:
          Consumer<UserInfoProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    if (provider.selectedEditScreen == 0) {
                      Navigator.pop(context);
                    } else {
                      provider.updateSelectedEditScreen(
                          UserInfoProvider.EDIT_SCREEN);
                    }
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 28,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(AppDimens.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Applogo(
                    hideTopLine: true,
                  ),
                  Text(
                    AppStrings.txtChangeMyDetails,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                  AppDimens.shape_20,
                  Expanded(child: screens[provider.selectedEditScreen ?? 0]),
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}
