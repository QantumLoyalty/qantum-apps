import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:provider/provider.dart';
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

class ChoosePaymentMethod extends StatefulWidget {
  Map<String, String>? arguments;

  ChoosePaymentMethod({super.key, this.arguments});

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod>
    with LoggingMixin {
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

        if (membershipProvider.isPaymentMethodUpdated != null) {
          logEvent(
              "isPaymentMethodUpdated: ${membershipProvider.isPaymentMethodUpdated}");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (membershipProvider.isPaymentMethodUpdated!) {
              logEvent("navigateAndClearStack called!!!");
              AppNavigator.navigateTo(
                  context, AppNavigator.pendingPaymentScreen);

              membershipProvider.resetUpdateMembershipPaymentResponse();
            } else {
              AppHelper.showErrorMessage(context, loc.msgCommonError);
              membershipProvider.resetUpdateMembershipPaymentResponse();
            }
          });
        }

        return Stack(
          children: [
            Column(
              children: [
                Applogo(),
                AppDimens.shape_30,
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      makePayment(userInfoProvider);
                    },
                    child: Image.asset(
                      "assets/common/pay_by_card.png",
                    ),
                  ),
                ),
                AppDimens.shape_30,
                AppButton(
                    text: loc.payReception,
                    onClick: () {
                      membershipProvider.updateMembershipPaymentMethod(
                          loc: loc);
                    }),
                AppDimens.shape_30,
                (widget.arguments != null &&
                        widget.arguments!.containsKey('isTestUser'))
                    ? AppButton(
                        text: "Continue for Review".toUpperCase(),
                        onClick: () {
                          AppNavigator.navigateAndClearStack(
                              context, AppNavigator.home);
                        })
                    : Container(),
                Expanded(child: Container()),
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

  makePayment(UserInfoProvider infoProvider) async {
    try {
      logEvent("User Info:: ${infoProvider.getUserInfo}");

      // 1️⃣ Create PaymentIntent (backend)
      await _membershipManagerProvider.createPaymentIntent(
        loc: loc,
        userId: infoProvider.getUserInfo!.id!,
      );

      final clientSecret = _membershipManagerProvider.paymentIntentClientSecret;

      if (clientSecret != null) {
        // 3️⃣ Init Payment Sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            style: ThemeMode.dark,
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Qantum',
          ),
        );

        // 4️⃣ Present Payment Sheet
        await Stripe.instance.presentPaymentSheet();

        // 5️⃣ (Optional) Verify locally — webhook is source of truth
        await _membershipManagerProvider.verifyPayment(
          loc: loc,
          userId: infoProvider.getUserInfo!.id!,
        );
      }
    } on StripeException catch (e) {
      logEvent("makePayment Error: $e");
      if (!mounted) return;
      AppHelper.showErrorMessage(context, loc.msgPaymentCancelled);
    }
  }

/*makePayment(UserInfoProvider infoProvider) async {
    try {
      logEvent("User Info:: ${infoProvider.getUserInfo}");

      /// CALLING CREATE PAYMENT INTENT API FOR GETTING THE INITIAL PARAMETERS ///
      await _membershipManagerProvider.createPaymentIntent(
          loc: loc, userId: infoProvider.getUserInfo!.id!);
      logEvent(
          "paymentIntentClientSecret: ${_membershipManagerProvider.paymentIntentClientSecret}");
      if (_membershipManagerProvider.paymentIntentClientSecret != null) {



        await Stripe.instance.applySettings(


        );

        /// INSTANTIATING THE PAYMENT SHEET AND PRESENTING IT TO THE USER ///
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              style: ThemeMode.dark,
              paymentIntentClientSecret:
                  _membershipManagerProvider.paymentIntentClientSecret!,
              merchantDisplayName: 'Qantum'),
        );
        await Stripe.instance.presentPaymentSheet();

        /// VERIFYING THE PAYMENT AND UPDATING THE MEMBERSHIP STATUS ///
        await _membershipManagerProvider.verifyPayment(
            loc: loc, userId: infoProvider.getUserInfo!.id!);
      }
    } on StripeException catch (e) {
      logEvent("makePayment Error: $e");
      if (!mounted) return;
      AppHelper.showErrorMessage(context, loc.msgPaymentCancelled);
    }
  }*/
}
