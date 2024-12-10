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
          padding: const EdgeInsets.all(10),
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                const HomeAppBar(),
                AppDimens.shape_20,
                Expanded(child: provider.selectedScreen),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children: List.generate(provider.homeNavigationList.length,
                      (index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1)),
                      elevation: 1,
                      color: Theme.of(context).buttonTheme.colorScheme?.primary,
                      child: InkWell(
                        onTap: () {
                          provider.updateSelectedOption(index);
                        },
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                provider.homeNavigationList[index].icon,
                                size: 26,
                                color: (provider.selectedOption == index)
                                    ? Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .selectedItemColor
                                    : Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedItemColor,
                              ),
                              AppDimens.shape_5,
                              Text(
                                provider.homeNavigationList[index].name
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight:
                                        (provider.selectedOption == index)
                                            ? FontWeight.w900
                                            : FontWeight.w500,
                                    color: (provider.selectedOption == index)
                                        ? Theme.of(context)
                                            .bottomNavigationBarTheme
                                            .selectedItemColor
                                        : Theme.of(context)
                                            .bottomNavigationBarTheme
                                            .unselectedItemColor),
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
                                  ? Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .selectedItemColor
                                  : Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor),
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
