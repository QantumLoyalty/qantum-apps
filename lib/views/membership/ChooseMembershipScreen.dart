import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/utils/AppColors.dart';
import '/view_models/UserInfoProvider.dart';
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
  Map<String, String>? arguments;

  ChooseMembershipScreen({super.key, this.arguments});

  @override
  State<ChooseMembershipScreen> createState() => _ChooseMembershipScreenState();
}

class _ChooseMembershipScreenState extends State<ChooseMembershipScreen>
    with LoggingMixin {
  late AppLocalizations loc;
  late TextEditingController controller;
  late MembershipManagerProvider _membershipManagerProvider;
  final formatter = NumberFormat("##0.00");

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
      body: SafeArea(child:
          Consumer2<MembershipManagerProvider, UserInfoProvider>(
              builder: (context, provider, userInfoProvider, child) {
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
                      /* Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                onSurfaceVariant: Colors.white,
                              ),
                        ),
                        child: provider.menuEntries != null
                            ? DropdownMenu<MembershipModel>(
                                menuHeight: 250,
                                width: double.infinity,
                                controller: controller,
                                hintText: loc.selectMembership,
                                initialSelection: provider.selectedMembership,
                                dropdownMenuEntries: provider.menuEntries!,
                                onSelected: (MembershipModel? value) {
                                  provider.updateDropdownValue(value!);
                                  setState(() {
                                    controller.text =
                                        "${value.membershipName} - \$${value.calculatedPrice != null ? formatter.format(value.calculatedPrice) : 0.00}";
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
                      )*/

                      provider.membershipList.isNotEmpty
                          ? Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, position) {
                                    MembershipModel membership =
                                        provider.membershipList[position];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: ListTile(
                                        onTap: () {
                                          provider
                                              .updateDropdownValue(membership);
                                        },
                                        tileColor:
                                            provider.selectedMembership !=
                                                        null &&
                                                    provider.selectedMembership!
                                                            .id ==
                                                        membership.id
                                                ? AppColors.white.withAlpha(50)
                                                : Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: AppColors.white,
                                                width: 1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        title: Text(
                                          "${membership.membershipName} - \$${membership.calculatedPrice != null ? membership.calculatedPrice!.toStringAsFixed(2) : "0.00"}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: provider.membershipList.length >= 2
                                      ? 2
                                      : provider.membershipList.length,
                                ),
                                AppDimens.shape_30,
                                Text(
                                  loc.msgForOtherMembershipSeeReception,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 17),
                                ),
                                AppDimens.shape_30,
                              ],
                            )
                          : Container(),
                    ],
                  ))),
                  AppDimens.shape_20,
                  AppButton(
                    text: loc.next.toUpperCase(),
                    onClick: () {
                      if (provider.selectedMembership != null) {
                        Map<String, String> args = {};
                        if (widget.arguments != null &&
                            widget.arguments!.containsKey("isTestUser")) {
                          args['isTestUser'] = "true";
                        }

                        AppNavigator.navigateAndClearStack(
                            context, AppNavigator.selfieUploadScreen,
                            arguments: args);
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
                      loaderMessage: provider.loaderMessage,
                    )
                  : Container()
            ],
          ),
        );
      })),
    );
  }
}
