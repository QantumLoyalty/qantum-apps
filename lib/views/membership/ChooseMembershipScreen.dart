import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import '../../core/navigation/AppNavigator.dart';
import '/core/utils/AppHelper.dart';
import '/data/models/MembershipModel.dart';
import '/views/common_widgets/AppLoader.dart';
import '/l10n/app_localizations.dart';
import '/view_models/MembershipManagerProvider.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class ChooseMembershipScreen extends StatefulWidget {
  Map<String, dynamic> args;

  ChooseMembershipScreen({super.key, required this.args});

  @override
  State<ChooseMembershipScreen> createState() => _ChooseMembershipScreenState();
}

class _ChooseMembershipScreenState extends State<ChooseMembershipScreen>
    with LoggingMixin {
  late AppLocalizations loc;
  late TextEditingController controller;
  late MembershipManagerProvider _membershipManagerProvider;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _membershipManagerProvider =
        Provider.of<MembershipManagerProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _membershipManagerProvider.fetchMembership(loc: loc);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      body: SafeArea(child: Consumer<MembershipManagerProvider>(
          builder: (context, provider, child) {
        // DISPLAYING NETWORK RESPONSE
        if (provider.isPaymentVerified != null) {
          logEvent("isPaymentVerified: ${provider.isPaymentVerified}");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (provider.isPaymentVerified!) {
              logEvent("navigateAndClearStack called!!!");
              AppNavigator.navigateAndClearStack(context, AppNavigator.home);
            } else {
              AppHelper.showErrorMessage(context, loc.msgCommonError);
              provider.resetVerifyPaymentResponse();
            }
          });
        }

        return Container(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Applogo(
                        iconPadding: 30.0,
                        customIconHeight: 150.0,
                        customIconWidth: 180.0,
                      ),
                      Text(
                        loc.chooseYourMembership,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      AppDimens.shape_20,
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                onSurfaceVariant: Colors.white,
                              ),
                        ),
                        child: provider.menuEntries != null
                            ? DropdownMenu<MembershipModel>(
                                width: double.infinity,
                                controller: controller,
                                hintText: loc.selectMembership,
                                initialSelection: provider.selectedMembership,
                                dropdownMenuEntries: provider.menuEntries!,
                                onSelected: (MembershipModel? value) {
                                  provider.updateDropdownValue(value!);
                                  setState(() {
                                    controller.text =
                                        "${value.membershipName} - \$${value.calculatedPrice}";
                                  });
                                },
                                inputDecorationTheme: InputDecorationTheme(
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(80),
                                  iconColor: Colors.white,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                                menuStyle: const MenuStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                  surfaceTintColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero),
                                  elevation: WidgetStatePropertyAll(0),
                                  fixedSize: WidgetStatePropertyAll(
                                      Size.fromWidth(double.infinity)),
                                  maximumSize: WidgetStatePropertyAll(
                                      Size.fromWidth(double.infinity)),
                                ),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ))),
                  AppDimens.shape_20,
                  AppButton(
                    text: loc.next.toUpperCase(),
                    onClick: () {
                      if (provider.selectedMembership != null) {
                        makePayment();
                      } else {
                        AppHelper.showErrorMessage(
                            context, loc.selectMembershipPlan);
                      }

                      /*AppNavigator.navigateAndClearStack(
                        context,
                        AppNavigator.home,
                      );*/
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppIcons.lightBulb,
                          width: 20,
                          height: 20,
                        ),
                        AppDimens.shape_10,
                        Expanded(
                          child: Text(
                            loc.membershipRequiresApproval,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              provider.showLoader != null && provider.showLoader!
                  ? AppLoader(
                      loaderMessage: provider.loaderMessage,
                    )
                  : Container()
            ],
          ),
        );
      })),
    );
  }

  makePayment() async {
    try {
      /// CALLING CREATE PAYMENT INTENT API FOR GETTING THE INITIAL PARAMETERS ///
      await _membershipManagerProvider.createPaymentIntent(
          loc: loc, userId: widget.args['userId']);
      logEvent(
          "paymentIntentClientSecret: ${_membershipManagerProvider.paymentIntentClientSecret}");
      if (_membershipManagerProvider.paymentIntentClientSecret != null) {
        /// INSTANTIATING THE PAYMENT SHEET AND PRESENTING IT TO THE USER ///
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                style: ThemeMode.dark,
                paymentIntentClientSecret:
                    _membershipManagerProvider.paymentIntentClientSecret!,
                merchantDisplayName: 'Qantum'));
        await Stripe.instance.presentPaymentSheet();
        /* if (!mounted) return;
        AppHelper.showSuccessMessage(context, "Payment Successful");
*/

        /// VERIFYING THE PAYMENT AND UPDATING THE MEMBERSHIP STATUS ///
        await _membershipManagerProvider.verifyPayment(
            loc: loc, userId: widget.args['userId']);
      }
    } on StripeException catch (e) {
      logEvent("makePayment Error: $e");
      if (!mounted) return;
      AppHelper.showErrorMessage(context, e.error.message ?? "Payment Failed");
    }
  }
}
