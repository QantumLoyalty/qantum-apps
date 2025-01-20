import 'package:flutter/material.dart';

import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';

class ClubAndMembership extends StatelessWidget {
  const ClubAndMembership({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true, title: AppStrings.txtClubAndMembership),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme!
                    .primary
                    .withValues(alpha: 0.2),
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
                      AppStrings.txtClubCode,
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary),
                    ),
                    AppDimens.shape_15,
                    TextFormField(
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!),
                      maxLines: 1,
                      maxLength: 80,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        hintText: AppStrings.msgEnterClubCode,
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor!
                                .withValues(alpha: 0.2)),
                        filled: true,
                        fillColor: AppColors.white.withValues(alpha: 0.2),
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
                    AppButton(
                        text: AppStrings.txtAdd.toUpperCase(), onClick: () {})
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
