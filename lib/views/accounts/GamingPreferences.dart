import 'package:flutter/material.dart';

import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';

class GamingPreferences extends StatelessWidget {
  Map<String, String> items = {
    "MANAGE LIMITS":
        "Time and spend limits allow you to manage and track your gaming activity",
    "ACTIVITY SNAPSHOT": "See your point history",
    "GAMING SUPPORT": "Find the right support for you",
    "SELF EXCLUSION": "Set self exclusion privately & confidentially"
  };

  GamingPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true, title: AppStrings.txtGamingPreferences),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context).canvasColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppDimens.shape_10,
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Your Usage",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!)),
                      TextSpan(
                          text: " (Daily)",
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!
                                  .withValues(alpha: 0.5)))
                    ]),
                  ),
                  AppDimens.shape_20,
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, item) {
                        return Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 10),
                            tileColor: AppColors.white.withValues(alpha: 0.15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            trailing: Icon(Icons.chevron_right,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor),
                            title: Text(
                              items.keys.elementAt(item),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            subtitle: Text(
                              items[items.keys.elementAt(item)]!,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                      itemCount: items.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return AppDimens.shape_10;
                      },
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
