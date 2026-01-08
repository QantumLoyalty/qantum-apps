import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/MembershipManagerProvider.dart';
import '../../core/utils/AppHelper.dart';
import '../../services/PaymentService.dart';
import '/core/navigation/AppNavigator.dart';
import '/views/common_widgets/AppButton.dart';
import '/view_models/UserInfoProvider.dart';
import '/views/common_widgets/AppScaffold.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/utils/AppDimens.dart';
import '../../l10n/app_localizations.dart';
import '../common_widgets/AppLogo.dart';
import 'widgets/BottomInfoWidget.dart';

class PendingPaymentScreen extends StatefulWidget {
  const PendingPaymentScreen({super.key});

  @override
  State<PendingPaymentScreen> createState() => _PendingPaymentScreenState();
}

class _PendingPaymentScreenState extends State<PendingPaymentScreen>
    with LoggingMixin {
  AppLocalizations? loc;
  late UserInfoProvider userInfoProvider;
  late MembershipManagerProvider membershipManagerProvider;

  @override
  void initState() {
    super.initState();
    userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    membershipManagerProvider =
        Provider.of<MembershipManagerProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userInfoProvider.runFetchProfileTimer();
      membershipManagerProvider.checkSelectedMembershipInLocal();
    });
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(body: SafeArea(child: Consumer<UserInfoProvider>(
      builder: (context, provider, child) {
        if (provider.getUserInfo != null && !provider.isNavigated) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (await AppHelper.checkIfUserHasPurchasedTheMembership()) {
              /// ALREADY PURCHASED THE MEMBERSHIP
              AppNavigator.navigateAndClearStack(context, AppNavigator.home);
              provider.markNavigated();
            }
          });
        }

        if (membershipManagerProvider.isPaymentVerified != null) {
          logEvent(
              "isPaymentVerified: ${membershipManagerProvider.isPaymentVerified}");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (membershipManagerProvider.isPaymentVerified!) {
              logEvent("navigateAndClearStack called!!!");
              AppNavigator.navigateAndClearStack(context, AppNavigator.home);
              membershipManagerProvider.resetVerifyPaymentResponse();
            } else {
              AppHelper.showErrorMessage(context, loc!.msgCommonError);
              membershipManagerProvider.resetVerifyPaymentResponse();
            }
          });
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              loc!.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          Expanded(
                              flex: 5,
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
                              flex: 8,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              loc!.txtMembership,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          AppDimens.shape_10,
                          Expanded(
                              flex: 9,
                              child: Text(
                                loc!.waitingPayment,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                              ))
                        ],
                      ),
                      AppDimens.shape_60,
                      (provider.getUserInfo != null &&
                              provider.getUserInfo!.licenceFront != null &&
                              provider.getUserInfo!.licenceFront!.isNotEmpty &&
                              provider.getUserInfo!.licenceBack != null &&
                              provider.getUserInfo!.licenceBack!.isNotEmpty)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, right: 35),
                                  child: Text(
                                    loc!.activateMessage,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                  ),
                                ),
                                AppDimens.shape_30,
                                AppButton(
                                    text: loc!.payNow.toUpperCase(),
                                    onClick: () async {
                                      await PaymentService.makePayment(
                                          context: context,
                                          loc: loc!,
                                          membershipManagerProvider:
                                              membershipManagerProvider,
                                          userInfoProvider: userInfoProvider);
                                    }),

                                AppDimens.shape_20,

                                  (provider.getUserInfo != null &&
                                    provider.getUserInfo!.bluizeUniqueUserId=="4a9ec9ef-aa36-49c0-ba3b-e6b36b14d07b")
                                    ? AppButton(
                                    text: "Continue for Review".toUpperCase(),
                                    onClick: () {
                                      AppNavigator.navigateAndClearStack(
                                          context, AppNavigator.home);
                                    })
                                    : Container(),


                              ],
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 35, right: 35),
                              child: Text(
                                loc!.payAtReception.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                              ),
                            ),
                    ],
                  ))),
                  AppDimens.shape_10,
                  BottomInfoWidget(
                    message: loc!.membershipRequiresApproval,
                  )
                ],
              ),
            )
          ],
        );
      },
    )));
  }
}
