import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/views/home/widgets/HomeAppBar.dart';

import '../../core/utils/AppDimens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
              left: 10, right: 10, bottom: 10, top: AppDimens.screenPadding),
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                const HomeAppBar(),
                Expanded(child: provider.selectedScreen),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children:
                      List.generate(provider.homeNavigationList.length, (index) {
                    return InkWell(
                      onTap: () {
                        provider.updateSelectedOption(index);
                      },
                      child: Container(
                        color: Theme.of(context).buttonTheme.colorScheme?.primary,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                provider.homeNavigationList[index].icon,
                                size: 26,
                                color: (provider.selectedOption == index)
                                    ? AppColors.white
                                    : Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                              ),
                              AppDimens.shape_10,
                              Text(
                                provider.homeNavigationList[index].name
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: (provider.selectedOption == index)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: (provider.selectedOption == index)
                                        ? AppColors.white
                                        : Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                AppDimens.shape_10,
                InkWell(
                  onTap: () {
                    provider.openMyDigitalCardScreen();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 18, bottom: 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          child: Container(
                            width: 60,
                            height: 40,
                            color: Colors.red,
                          ),
                        ),
                        AppDimens.shape_10,
                        Text(
                          AppStrings.txtMyDigitalCard.toUpperCase(),
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: (provider.selectedOption == -2)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: (provider.selectedOption == -2)
                                  ? AppColors.white
                                  : Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
