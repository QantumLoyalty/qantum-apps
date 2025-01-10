import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';

class MyVenuesHomeScreen extends StatefulWidget {
  const MyVenuesHomeScreen({super.key});

  @override
  State<MyVenuesHomeScreen> createState() => _MyVenuesHomeScreenState();
}

class _MyVenuesHomeScreenState extends State<MyVenuesHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                children: [
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: Image.asset(
                              'assets/common/venue_placeholder_1.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      )),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/common/venue_placeholder_2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Card(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/common/venue_placeholder_2.png',
                          fit: BoxFit.cover,
                        ),
                      ))),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/common/venue_placeholder_1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/common/venue_placeholder_2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Card(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/common/venue_placeholder_2.png',
                          fit: BoxFit.cover,
                        ),
                      ))),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.txtCongratulations,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              Text(
                'You\'ve earned a free main course at Vinny\'s Italian',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(85, 30),
                              padding: EdgeInsets.zero,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark),
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              AppStrings.txtMoreInfo.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          )),
                    ],
                  )),
                  AppDimens.shape_10,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: const Size(85, 30),
                              padding: EdgeInsets.zero,
                              backgroundColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .secondary),
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              AppStrings.txtRedeem.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          )),
                    ],
                  )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
