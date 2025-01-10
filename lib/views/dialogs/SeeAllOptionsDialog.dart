import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/views/common_widgets/IconTextWidget.dart';

class SeeAllOptionsDialog {
  static final SeeAllOptionsDialog _seeAllOptionsDialog =
      SeeAllOptionsDialog._internal();

  static SeeAllOptionsDialog getInstance() {
    return _seeAllOptionsDialog;
  }

  SeeAllOptionsDialog._internal();

  showSeeAllOptionsDialog(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                left: 10,
                right: 10,
                bottom: buttonPosition.dy + 175,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      border:
                          Border.all(color: Theme.of(context).iconTheme.color!),
                      borderRadius: BorderRadius.circular(10)),
                  child: Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: provider.homeSeeAllOptionsList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.transparent,
                            child: IconTextWidget(
                              orientation: IconTextWidget.VERTICAL,
                              icon: provider.homeSeeAllOptionsList[index].icon,
                              text: provider.homeSeeAllOptionsList[index].name
                                  .toUpperCase(),
                              textColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              textSize: 10,
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Theme.of(context).iconTheme.color!,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        });
                  }),
                ),
              )
            ],
          );
        });
  }
}
