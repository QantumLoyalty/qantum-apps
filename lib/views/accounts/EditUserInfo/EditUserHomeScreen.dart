import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/AppHelper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../view_models/UserInfoProvider.dart';
import '/views/common_widgets/AppLoader.dart';
import '../../../core/utils/AppDimens.dart';
import '../../common_widgets/AppCustomButton.dart';
import '../widgets/DetailCard.dart';
import '../widgets/PhoneCard.dart';
import '../widgets/RecoveryEmailCard.dart';

class EditUserHomeScreen extends StatelessWidget {
  const EditUserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations loc = AppLocalizations.of(context)!;

    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      if (provider.isNetworkError != null) {
        Future.delayed(Duration.zero, () {
          if (provider.isNetworkError!) {
            AppHelper.showErrorMessage(
                context, provider.networkMessage ?? loc.msgProfileUpdateError);
          } else {
            AppHelper.showSuccessMessage(context,
                provider.networkMessage ?? loc.msgProfileUpdateSuccess);
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
              AppCustomButton(
                text: loc.txtSaveAndUpdate.toUpperCase(),
                textColor: AppHelper.getEditAccountsButtonTextColor(context),
                onClick: () {
                  provider.updateUserInformation(loc: loc);
                },
                style: AppHelper.getEditAccountsButtonStyle(context),
              ),
            ],
          ),
          provider.showLoader != null && provider.showLoader!
              ? AppLoader(
                  loaderMessage: loc.msgProfileUpdateLoading,
                )
              : Container()
        ],
      );
    });
  }
}
