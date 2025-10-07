import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';

class GamingPreferences extends StatelessWidget {
  Map<String, String> items = {
    "txtManageLimits": "msgTimeAndSpendLimits",
    "txtActivitySnapshot": "msgSeeYourPointHistory",
    "txtGamingSupport": "msgFindSupport",
    "txtSelfExclusion": "msgSetSelfExclusion"
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
                showBackButton: true,
                title: AppLocalizations.of(context)!.txtGamingPreferences),
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
                          text: AppLocalizations.of(context)!.txtYourUsage,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppThemeCustom.getAccountSectionItemStyle(
                                  context))),
                      TextSpan(
                          text: AppLocalizations.of(context)!.txtDaily,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppThemeCustom.getAccountSectionItemStyle(
                                      context)!
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
                                color:
                                    AppThemeCustom.getAccountSectionItemStyle(
                                        context)),
                            title: Text(
                              translateContent(AppLocalizations.of(context)!,
                                  items.keys.elementAt(item)),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppThemeCustom.getAccountSectionItemStyle(
                                          context)),
                            ),
                            subtitle: Text(
                              translateContent(AppLocalizations.of(context)!,
                                  items[items.keys.elementAt(item)]!),
                              style: TextStyle(
                                  color:
                                      AppThemeCustom.getAccountSectionItemStyle(
                                          context)),
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

  String translateContent(AppLocalizations loc, String key) {
    switch (key) {
      case "txtManageLimits":
        return loc.txtManageLimits.toUpperCase();
      case "txtActivitySnapshot":
        return loc.txtActivitySnapshot.toUpperCase();
      case "txtGamingSupport":
        return loc.txtGamingSupport.toUpperCase();
      case "txtSelfExclusion":
        return loc.txtSelfExclusion.toUpperCase();
      case "msgTimeAndSpendLimits":
        return loc.msgTimeAndSpendLimits;
      case "msgSeeYourPointHistory":
        return loc.msgSeeYourPointHistory;
      case "msgFindSupport":
        return loc.msgFindSupport;
      case "msgSetSelfExclusion":
        return loc.msgSetSelfExclusion;
      default:
        return "";
    }
  }
}
