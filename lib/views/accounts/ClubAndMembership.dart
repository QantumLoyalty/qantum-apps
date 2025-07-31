import 'package:flutter/material.dart';
import '../../core/flavors_config/flavor_config.dart';
import '/views/common_widgets/AppCustomButton.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';

class ClubAndMembership extends StatelessWidget {
  ClubAndMembership({super.key});

  Flavor selectedFlavor = FlavorConfig.instance.flavor!;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true,
                title: selectedFlavor == Flavor.mhbc
                    ? AppStrings.txtSponsorship
                    : AppStrings.txtClubAndMembership),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context).canvasColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppDimens.shape_10,
                    Text(
                      "Obtain your club code then enter it below and earn rewards & get benefits for your club.",
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                    ),
                    AppDimens.shape_20,
                    Text(
                      AppStrings.txtClubCode.toUpperCase(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    AppDimens.shape_15,
                    TextFormField(
                      style: TextStyle(
                          fontSize: 16,
                          color: AppThemeCustom.getTextFieldTextColor(context)),
                      maxLines: 1,
                      maxLength: 80,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        hintText: AppStrings.msgEnterClubCode,
                        hintStyle: TextStyle(
                            fontSize: 20, color: Theme.of(context).hintColor),
                        filled: true,
                        fillColor:
                            AppThemeCustom.getTextFieldBackground(context),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    AppDimens.getCustomBoxShape(30),
                    AppCustomButton(
                        style: AppHelper.getAccountsButtonStyle(context),
                        textColor:
                            AppHelper.getAccountsButtonTextColor(context),
                        text: AppStrings.txtAdd.toUpperCase(),
                        onClick: () {})
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
