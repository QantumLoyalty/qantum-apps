import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/models/MoreButtonModel.dart';

import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../view_models/HomeProvider.dart';
import '../../common_widgets/IconTextWidget.dart';

class AllMenuItemsWidget extends StatelessWidget {
  const AllMenuItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 15,
      left: 15,
      child: Card(
        elevation: 10,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppThemeCustom.getSeeAllBackground(context),
              border:
                  Border.all(color: AppThemeCustom.getSeeAllBorder(context)),
              borderRadius: BorderRadius.circular(10)),
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
            if (provider.moreButtonsMap != null &&
                provider.moreButtonsMap!.isNotEmpty) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: provider.moreButtonsMap!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.5),
                  itemBuilder: (context, index) {
                    if (provider.moreButtonsMap![index + 1]
                        is MoreButtonModel) {
                      return InkWell(
                        onTap: () {
                          if (AppHelper.verifyURL(
                              provider.moreButtonsMap![index + 1].link)) {
                            AppNavigator.navigateTo(
                                context, AppNavigator.appWebView,
                                arguments:
                                    provider.moreButtonsMap![index + 1].link);
                          } else {
                            AppHelper.showErrorMessage(
                                context, "Incorrect URL!!!");
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Theme.of(context).iconTheme.color!,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                provider.moreButtonsMap![index + 1].name
                                    .toUpperCase(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 10),
                              ),
                            )),
                      );
                    } else {
                      /*return Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: Theme.of(context).iconTheme.color!,
                                width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      );*/
                      return Container();
                    }
                  });
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
