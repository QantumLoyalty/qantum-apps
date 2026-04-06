import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/enums/MembershipFlowSource.dart';
import 'package:qantum_apps/core/utils/AppIcons.dart';
import 'package:qantum_apps/views/common_widgets/AppCustomButton.dart';
import '../../services/PaymentService.dart';
import '/views/common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '/core/mixins/logging_mixin.dart';
import '/core/utils/AppDimens.dart';
import '/views/common_widgets/AppScaffold.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppHelper.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/MembershipManagerProvider.dart';
import '../../view_models/UserInfoProvider.dart';
import 'widgets/BottomInfoWidget.dart';

class EarlyBirdRenewalMembershipScreen extends StatefulWidget {
  Map<String, String>? arguments;

  EarlyBirdRenewalMembershipScreen({super.key, this.arguments});

  @override
  State<EarlyBirdRenewalMembershipScreen> createState() =>
      _EarlyBirdRenewalMembershipState();
}

class _EarlyBirdRenewalMembershipState
    extends State<EarlyBirdRenewalMembershipScreen> with LoggingMixin {
  late AppLocalizations loc;
  late MembershipManagerProvider _membershipManagerProvider;

  @override
  void initState() {
    super.initState();
    _membershipManagerProvider =
        Provider.of<MembershipManagerProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserInfoProvider>(context, listen: false).retrieveUserInfo();
    });
    logEvent("widget.arguments >> ${widget.arguments}");
    logEvent(
        "Selected Membership >> ${_membershipManagerProvider.selectedMembership.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      child: Consumer2<MembershipManagerProvider, UserInfoProvider>(
          builder: (context, membershipProvider, userInfoProvider, child) {
        // DISPLAYING NETWORK RESPONSE
        if (membershipProvider.isPaymentVerified != null) {
          logEvent(
              "isPaymentVerified: ${membershipProvider.isPaymentVerified}");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (membershipProvider.isPaymentVerified!) {
              logEvent("navigateAndClearStack called!!!");
              AppNavigator.navigateAndClearStack(context, AppNavigator.home);
              membershipProvider.resetVerifyPaymentResponse();
            } else {
              AppHelper.showErrorMessage(context, loc.msgCommonError);
              membershipProvider.resetVerifyPaymentResponse();
            }
          });
        }

        return Stack(
          children: [
            Column(
              children: [
                Applogo(),
                AppDimens.shape_30,
                Text(
                  loc.renewMembership,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                AppDimens.shape_40,
                Text(
                  "${membershipProvider.selectedMembership!.membershipName}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                AppDimens.shape_40,
                Text(
                  loc.paymentOptions,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                AppDimens.shape_30,
                Row(
                  children: [
                    ImageIcon(
                      AssetImage(AppIcons.payByCard),
                      size: 42,
                    ),
                    AppDimens.shape_10,
                    Expanded(
                      child: AppButton(
                          text: loc.payByCard.toUpperCase(),
                          onClick: () async {
                            //  makePayment(userInfoProvider);
                            String renewType = "none";
                            String? paymentFlowSource;

                            if (widget.arguments != null &&
                                widget.arguments!
                                    .containsKey("fromRenewMembership")) {
                              renewType = "renew";
                            }

                            if (widget.arguments != null &&
                                widget.arguments!
                                    .containsKey("membershipFlowSource")) {
                              paymentFlowSource =
                                  widget.arguments!["membershipFlowSource"];
                            }

                            await PaymentService.makePayment(
                                context: context,
                                loc: loc,
                                membershipManagerProvider:
                                    _membershipManagerProvider,
                                userInfoProvider: userInfoProvider,
                                renewType: renewType,
                                paymentFlowSource:
                                    MembershipFlowSource.earlyBird.name);
                          }),
                    ),
                  ],
                ),
                AppDimens.shape_30,
                Expanded(child: Container()),
                AppDimens.shape_30,
                AppCustomButton(
                    text: loc.txtCancel.toUpperCase(),
                    onClick: () {
                      AppNavigator.navigateAndClearStack(
                          context, AppNavigator.home);
                    }),
                AppDimens.shape_30,
                BottomInfoWidget(
                  message: loc.membershipRequiresApproval,
                )
              ],
            ),
            membershipProvider.showLoader != null &&
                    membershipProvider.showLoader!
                ? AppLoader(
                    loaderMessage: membershipProvider.loaderMessage,
                  )
                : Container()
          ],
        );
      }),
    )));
  }
}
