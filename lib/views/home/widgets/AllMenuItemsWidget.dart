import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppThemeCustom.getPointsBalanceBackground(context),
            border: Border.all(color: AppThemeCustom.getPointsBalanceBorder(context)),
            borderRadius: BorderRadius.circular(10)),
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          return GridView.builder(
              shrinkWrap: true,
              itemCount: provider.homeSeeAllOptionsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.5),
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Theme.of(context).iconTheme.color!,
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child:
                        /*IconTextWidget(
                    orientation: IconTextWidget.VERTICAL,
                    icon: provider.homeSeeAllOptionsList[index].icon,
                    text: provider.homeSeeAllOptionsList[index].name
                        .toUpperCase(),
                    textColor:
                        Theme.of(context).textSelectionTheme.selectionColor,
                    textSize: 10,
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Theme.of(context).iconTheme.color!,
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                  ),*/
                        Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            provider.homeSeeAllOptionsList[index].icon,
                          ),
                          FittedBox(
                            child: Text(
                              provider.homeSeeAllOptionsList[index].name
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ));
              });
        }),
      ),
    );
  }
}
