import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/app_localizations.dart';
import '/view_models/MembershipManagerProvider.dart';

import '../../core/mixins/logging_mixin.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class ChooseMembershipScreen extends StatefulWidget {
  const ChooseMembershipScreen({super.key});

  @override
  State<ChooseMembershipScreen> createState() => _ChooseMembershipScreenState();
}

class _ChooseMembershipScreenState extends State<ChooseMembershipScreen>
    with LoggingMixin {
  late AppLocalizations loc;
  late TextEditingController controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
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
        if (controller.text.isEmpty) {
          provider.updateDropdownValue(MembershipManagerProvider.list.first);
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
                        child: DropdownMenu<String>(
                          width: double.infinity,
                          controller: controller,
                          initialSelection:
                              MembershipManagerProvider.list.first,
                          dropdownMenuEntries: provider.menuEntries,
                          onSelected: (String? value) {
                            provider.updateDropdownValue(value!);
                            setState(() {
                              controller.text = value;
                            });
                          },
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Colors.white.withAlpha(5),
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
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            surfaceTintColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
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
                        ),
                      )
                    ],
                  ))),
                  AppDimens.shape_20,
                  AppButton(
                    text: loc.next.toUpperCase(),
                    onClick: () {
                      AppNavigator.navigateAndClearStack(
                        context,
                        AppNavigator.home,
                      );
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
              )
            ],
          ),
        );
      })),
    );
  }
}
