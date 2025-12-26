import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../core/utils/AppHelper.dart';
import '../l10n/app_localizations.dart';
import '../view_models/MembershipManagerProvider.dart';
import '../view_models/UserInfoProvider.dart';

class PaymentService {
  static PaymentService? _instance;

  PaymentService._internal();

  static PaymentService getInstance() {
    _instance ??= PaymentService._internal();
    return _instance!;
  }

  static Future<void>  makePayment({
    required BuildContext context,
    required AppLocalizations loc,
    required MembershipManagerProvider membershipManagerProvider,
    required UserInfoProvider userInfoProvider,
  }) async {
    try {
      await membershipManagerProvider.createPaymentIntent(
        loc: loc,
        userId: userInfoProvider.getUserInfo!.id!,
      );

      final clientSecret = membershipManagerProvider.paymentIntentClientSecret;
      if (clientSecret != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                style: ThemeMode.dark,
                paymentIntentClientSecret:
                    membershipManagerProvider.paymentIntentClientSecret!,
                merchantDisplayName: 'Qantum'));
        await Stripe.instance.presentPaymentSheet();
        await membershipManagerProvider.verifyPayment(
          loc: loc,
          userId: userInfoProvider.getUserInfo!.id!,
        );
      }
    } on StripeException catch (e) {
      if (!Navigator.of(context).mounted) return;
      AppHelper.showErrorMessage(context, e.error.message ?? "Payment Failed");
    }
  }
}
