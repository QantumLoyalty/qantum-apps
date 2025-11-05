import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userInfoProvider.retrieveUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(body: SafeArea(child: Consumer<UserInfoProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    Applogo(),
                    AppDimens.shape_30,
                    Row(
                      children: [
                        Text(
                          loc!.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        AppDimens.shape_10,
                        Expanded(
                            child: Text(provider.getUserInfo != null
                                ? "${provider.getUserInfo!.firstName} ${provider.getUserInfo!.lastName}"
                                : ""))
                      ],
                    ),
                    AppDimens.shape_10,
                    Row(
                      children: [
                        Text(
                          loc!.cardNumber,
                          style: const TextStyle(fontSize: 12),
                        ),
                        AppDimens.shape_10,
                        Expanded(
                            child: Text(provider.getUserInfo != null
                                ? "${provider.getUserInfo!.cardNumber} ${provider.getUserInfo!.cardNumber}"
                                : ""))
                      ],
                    ),
                    AppDimens.shape_10,
                    Row(
                      children: [
                        Text(
                          loc!.txtMembership,
                          style: const TextStyle(fontSize: 12),
                        ),
                        AppDimens.shape_10,
                        Expanded(child: Text(loc!.waitingPayment))
                      ],
                    ),
                    AppDimens.shape_20,
                    Text(
                      loc!.activateMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    AppDimens.shape_10,
                    AppButton(
                        text: loc!.payNow,
                        onClick: () {
                          AppNavigator.navigateTo(
                              context, AppNavigator.chooseMembershipScreen);
                        })
                  ],
                ))),
                AppDimens.shape_10,
                BottomInfoWidget(
                  message: loc!.membershipRequiresApproval,
                )
              ],
            )
          ],
        );
      },
    )));
  }
}
