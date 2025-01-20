import 'package:flutter/material.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';

class CommunicationPreference extends StatefulWidget {
  const CommunicationPreference({super.key});

  @override
  State<CommunicationPreference> createState() =>
      _CommunicationPreferenceState();
}

class _CommunicationPreferenceState extends State<CommunicationPreference> {
  bool email = false;
  bool sms = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true,
                title: AppStrings.txtCommunicationPreferences),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    AppDimens.shape_5,
                    Text(
                      "Keeping in touch allows us to offer prizes,\nrewards & promotions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 14),
                    ),
                    AppDimens.shape_15,
                    Text(
                      "Below you can select how we can keep in touch with you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 12),
                    ),
                    AppDimens.shape_15,
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white.withValues(alpha: 0.15),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppDimens.shape_5,
                            Text(
                              AppStrings.txtCommunicationChannel.toUpperCase(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .primary,
                                  fontSize: 14),
                            ),
                            Text(
                              "How would you like to be notified?",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 12),
                            ),
                            SwitchListTile(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              contentPadding: EdgeInsets.zero,
                              value: sms,
                              inactiveTrackColor: AppColors.white,
                              activeTrackColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primary,
                              activeColor: AppColors.white,
                              inactiveThumbColor:
                                  Theme.of(context).primaryColorDark,
                              onChanged: (value) {
                                setState(() {
                                  sms = value;
                                });
                              },
                              title: Text(
                                AppStrings.txtSMS,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            SwitchListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              value: email,
                              inactiveTrackColor: AppColors.white,
                              activeTrackColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primary,
                              activeColor: AppColors.white,
                              inactiveThumbColor:
                                  Theme.of(context).primaryColorDark,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              title: Text(
                                AppStrings.txtEmail,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppDimens.shape_15,
                    Text(
                      "Please allow up to 24 hours for changes to take affect.",
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary,
                          fontSize: 12),
                    ),
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
