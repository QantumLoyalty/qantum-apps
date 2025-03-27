import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/AppHelper.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../view_models/UserInfoProvider.dart';
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
  late UserInfoProvider _userInfoProvider;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    _userInfoProvider.fetchUserProfile();
  }

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
                color: Theme.of(context).canvasColor,
              ),
              child: Consumer<UserInfoProvider>(
                  builder: (context, provider, child) {
                if (provider.isNetworkError != null &&
                    provider.networkMessage != null) {
                  Future.delayed(Duration.zero, () {
                    if (provider.isNetworkError!) {
                      AppHelper.showErrorMessage(
                          context, provider.networkMessage!);
                    } else {
                      AppHelper.showSuccessMessage(
                          context, provider.networkMessage!);
                    }
                    provider.resetNetworkResponse();
                  });
                }
                return Stack(
                  children: [
                    Padding(
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppDimens.shape_5,
                                Text(
                                  AppStrings.txtCommunicationChannel
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
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
                                  value: provider.getUserInfo != null &&
                                          provider.getUserInfo!.acceptsSMS !=
                                              null
                                      ? provider.getUserInfo!.acceptsSMS!
                                      : false,
                                  onChanged: (value) {
                                    provider.updateCommunicationPreferences(
                                        sms: value);
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
                                  value: provider.getUserInfo != null &&
                                          provider.getUserInfo!.acceptsEmail !=
                                              null
                                      ? provider.getUserInfo!.acceptsEmail!
                                      : false,
                                  onChanged: (value) {
                                    provider.updateCommunicationPreferences(
                                        email: value);
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
                          AppDimens.shape_15,
                          Text(
                            "Please allow up to 24 hours for changes to take affect.",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    provider.showLoader != null && provider.showLoader!
                        ? AppLoader(
                            loaderMessage: AppStrings.msgCommonLoader,
                          )
                        : Container()
                  ],
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
