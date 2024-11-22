import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';

import '../common_widgets/IconTextWidget.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppDimens.shape_20,
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.person_2_outlined,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  size: 30,
                ),
                Text(
                  "User Name",
                  style: TextStyle(
                      fontSize: 24,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                ),
                AppDimens.shape_20,
                IconTextWidget(
                  orientation: IconTextWidget.HORIZONTAL,
                  icon: Icons.card_giftcard,
                  iconSize: 18,
                  text: "10 May 2001",
                  iconColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  textColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                ),
                IconTextWidget(
                  orientation: IconTextWidget.HORIZONTAL,
                  icon: Icons.phone_android_outlined,
                  iconSize: 18,
                  text: "0123456789",
                  iconColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  textColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                ),
                IconTextWidget(
                  orientation: IconTextWidget.HORIZONTAL,
                  icon: Icons.email_outlined,
                  iconSize: 18,
                  text: "abc@gmail.com",
                  iconColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  textColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ],
            ),
          )),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                AppStrings.txtViewTermsConditions,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    AppStrings.txtCancelMyAccount,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    AppStrings.txtLogout,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'V1.19.5',
            style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textSelectionTheme.selectionColor),
          )
        ],
      ),
    );
  }
}
