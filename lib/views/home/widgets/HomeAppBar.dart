import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: AppDimens.appBarHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Hello ",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                  ),
                  TextSpan(
                    text: "USER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                  ),
                ])),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Valued ",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                      TextSpan(
                        text: "123456",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                    ])),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Consumer<HomeProvider>(builder: (context, provider, child) {
              return InkWell(
                onTap: () {
                  provider.openMyProfileScreen();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_2_outlined,
                      color: provider.selectedOption == -1
                          ? AppColors.white
                          : Theme.of(context).textSelectionTheme.selectionColor,
                      size: 18,
                    ),
                    Text(
                      AppStrings.txtMyProfile.toUpperCase(),
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: provider.selectedOption == -1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: provider.selectedOption == -1
                              ? AppColors.white
                              : Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
