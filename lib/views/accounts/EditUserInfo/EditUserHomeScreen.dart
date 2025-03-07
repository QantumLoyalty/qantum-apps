import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';

import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppStrings.dart';
import '../../common_widgets/AppButton.dart';
import '../widgets/DetailCard.dart';
import '../widgets/PhoneCard.dart';
import '../widgets/RecoveryEmailCard.dart';

class EditUserHomeScreen extends StatelessWidget {
  const EditUserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      if (provider.isNetworkError != null) {
        Future.delayed(Duration.zero, () {
          if (provider.isNetworkError!) {
            AppHelper.showErrorMessage(
                context,
                provider.networkMessage ??
                    "Ooppss.. something went wrong while updating your profile");
          } else {
            AppHelper.showSuccessMessage(
                context,
                provider.networkMessage ??
                    "Your profile is updated successfully!!");
          }

          provider.resetNetworkResponse(resetTempUser: false);
        });
      }

      return Stack(
        children: [
          Column(
            children: [
              DetailCard(
                editable: true,
              ),
              AppDimens.shape_10,
              RecoveryEmailCard(
                editable: true,
              ),
              AppDimens.shape_10,
              PhoneCard(editable: true),
              AppDimens.shape_30,
              AppButton(
                  text: AppStrings.txtSaveAndUpdate.toUpperCase(),
                  onClick: () {
                    provider.updateUserInformation();
                  }),
            ],
          ),
          provider.showLoader != null && provider.showLoader!
              ? AppLoader(
                  loaderMessage:
                      "Please wait, while we are updating your profile.",
                )
              : Container()
        ],
      );
    });
  }
}
