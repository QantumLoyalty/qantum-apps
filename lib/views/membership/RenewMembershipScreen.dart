import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/enums/FetchProfileState.dart';
import '../../core/enums/MembershipStatus.dart';
import '../../core/navigation/AppNavigator.dart';
import '/view_models/UserInfoProvider.dart';
import '/views/common_widgets/AppScaffold.dart';
import '../../core/utils/AppDimens.dart';
import '../../l10n/app_localizations.dart';
import '../../services/PaymentService.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLogo.dart';
import '/core/mixins/logging_mixin.dart';
import 'widgets/BottomInfoWidget.dart';

class RenewMembershipScreen extends StatelessWidget with LoggingMixin {
  AppLocalizations? loc;

  RenewMembershipScreen({super.key});
  bool _hasRedirectedToHome = false;

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context);

    return AppScaffold(body: SafeArea(
        child: Consumer<UserInfoProvider>(builder: (context, provider, child) {

          if (provider.getUserInfo != null) {
            if ((provider.membershipStatus ==
                MembershipStatus.active) &&
                !_hasRedirectedToHome && provider.fetchProfileState==FetchProfileState.loaded)
            {
              _hasRedirectedToHome = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppNavigator.navigateAndClearStack(
                    context, AppNavigator.home);
              });
            }
          }


      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.screenPadding),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Applogo(),
                      AppDimens.shape_30,
                      Text(
                        loc!.membershipRenewalTime,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                      AppDimens.shape_40,
                      Text(
                        loc!.yourMembershipExpired,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                      AppDimens.shape_20,
                      AppButton(
                        text: loc!.renewNow.toUpperCase(),
                        onClick: () {
                          Map<String, String> params = Map();
                          params['fromRenewMembership'] = "true";

                          AppNavigator.navigateAndClearStack(
                              context, AppNavigator.chooseMembershipScreen,
                              arguments: params);
                        },
                      ),
                      AppDimens.shape_30,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              loc!.name,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Text(
                                provider.getUserInfo != null
                                    ? "${provider.getUserInfo!.firstName} ${provider.getUserInfo!.lastName}"
                                    : "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                              ))
                        ],
                      ),
                      AppDimens.shape_10,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              loc!.cardNumber,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Text(
                                provider.getUserInfo != null
                                    ? "${provider.getUserInfo!.cardNumber}"
                                    : "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                              ))
                        ],
                      ),
                      AppDimens.shape_10,
                    ],
                  ),
                )),
                AppDimens.shape_10,
                BottomInfoWidget(
                  message: loc!.membershipRequiresApproval,
                )
              ],
            ),
          )
        ],
      );
    })));
  }
}
