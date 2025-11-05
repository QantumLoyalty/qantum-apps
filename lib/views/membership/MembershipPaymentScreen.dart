import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppIcons.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/MembershipManagerProvider.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLoader.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class MembershipPaymentScreen extends StatefulWidget {
  const MembershipPaymentScreen({super.key});

  @override
  State<MembershipPaymentScreen> createState() =>
      _MembershipPaymentScreenState();
}

class _MembershipPaymentScreenState extends State<MembershipPaymentScreen> {
  late AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;

    return AppScaffold(
      body: SafeArea(child: Consumer<MembershipManagerProvider>(
          builder: (context, provider, child) {
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
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Email"),
                              TextFormField(),
                              AppDimens.shape_10,
                              Text("Card Information"),
                              AppDimens.shape_5,
                              TextFormField(),
                              AppDimens.shape_5,
                              Row(
                                children: [
                                  Expanded(child: TextFormField()),
                                  Expanded(child: TextFormField()),
                                ],
                              ),
                              AppDimens.shape_10,
                              Text("Name on card"),
                              AppDimens.shape_5,
                              TextFormField(),
                              AppDimens.shape_15,
                              TextButton(
                                  onPressed: () {}, child: Text("Pay \$100.00"))
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
                  AppDimens.shape_20,
                  AppButton(
                    text: "CONFIRM PAYMENT",
                    onClick: () {
                      if (provider.selectedMembership != null) {
                      } else {
                        AppHelper.showErrorMessage(
                            context, loc.selectMembershipPlan);
                      }
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
                      loaderMessage: loc.fetchingMembershipPlan,
                    )
                  : Container()
            ],
          ),
        );
      })),
    );
  }
}
