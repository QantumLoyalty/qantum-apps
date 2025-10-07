import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppHelper.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../view_models/UserInfoProvider.dart';
import '../../core/utils/AppDimens.dart';
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
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();
    _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    _userInfoProvider.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true, title: loc.txtCommunicationPreferences),
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
                            loc.msgKeepingInTouch,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppThemeCustom.getAccountSectionItemStyle(context),
                                fontSize: 14),
                          ),
                          AppDimens.shape_15,
                          Text(
                            loc.msgSelectCommunicationPreference,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppThemeCustom.getAccountSectionItemStyle(context),
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
                                  loc.txtCommunicationChannel,
                                  style: TextStyle(
                                      color: AppThemeCustom.getAccountSectionItemStyle(context),
                                      fontSize: 15,fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  loc.msgNotificationPreference,
                                  style: TextStyle(
                                      color:AppThemeCustom.getAccountSectionItemStyle(context),
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
                                        sms: value,loc: loc);
                                  },
                                  title: Text(
                                    loc.txtSMS,
                                    style: TextStyle(
                                        color: AppThemeCustom.getAccountSectionItemStyle(context),
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
                                        email: value,loc: loc);
                                  },
                                  title: Text(
                                    loc.txtEmail,
                                    style: TextStyle(
                                        color: AppThemeCustom.getAccountSectionItemStyle(context),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppDimens.shape_15,
                          Text(
                            loc.msgCommunicationPreference,
                            style: TextStyle(
                                color: AppThemeCustom.getAccountSectionItemStyle(context),
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    provider.showLoader != null && provider.showLoader!
                        ? AppLoader(
                            loaderMessage: loc.msgCommonLoader,
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
