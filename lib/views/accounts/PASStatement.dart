import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../common_widgets/AppScaffold.dart';
import 'widgets/AccountsAppBar.dart';

class PASStatement extends StatelessWidget {
  final List<BarChartGroupData> _barGroups = [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          toY: 42812,
          color: Colors.lightBlueAccent,
          width: 30,
        ),
        BarChartRodData(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          toY: -5000,
          color: Colors.white,
          width: 30,
        ),
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          toY: 87204.9,
          color: Colors.lightBlueAccent,
          width: 30,
        ),
        BarChartRodData(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          toY: -7000,
          color: Colors.white,
          width: 30,
        ),
      ],
    ),
  ];

  PASStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true, title: AppStrings.txtPASStatement),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme!
                    .primary
                    .withValues(alpha: 0.2),
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  AppDimens.shape_20,
                  Text("Player Activity Statement for",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!)),
                  Text(
                    "(1 Jul 2023 to 30 September 2023)",
                    style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!
                            .withValues(alpha: 0.7)),
                  ),
                  AppDimens.shape_20,
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white.withValues(alpha: 0.15),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DETAILS",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary),
                          ),
                          AppDimens.shape_10,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Card #",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                ),
                              ),
                              AppDimens.shape_20,
                              Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total amount bet",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                ),
                              ),
                              AppDimens.shape_20,
                              Text(
                                "\$10000",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total amount won",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                ),
                              ),
                              AppDimens.shape_20,
                              Text(
                                "\$10000",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Net amount won or lost",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                ),
                              ),
                              AppDimens.shape_20,
                              Text(
                                "\$10000",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                              )
                            ],
                          ),
                          AppDimens.shape_10,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total days played",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                ),
                              ),
                              AppDimens.shape_20,
                              Text(
                                "30",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total hours played",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                ),
                              ),
                              AppDimens.shape_20,
                              Text(
                                "20",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppDimens.shape_20,
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white.withValues(alpha: 0.15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PERFORMANCE",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary),
                          ),
                          AppDimens.shape_10,
                          SizedBox(
                            height: 300,
                            child: BarChart(BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 100000,
                              minY: -20000,
                              barGroups: _barGroups,
                              baselineY: 0,
                              gridData: FlGridData(
                                show: true,
                                horizontalInterval: 20000,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: value == 0
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                    strokeWidth: value == 0 ? 1 : 0,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 20000,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value > 0
                                            ? '${value ~/ 1000}K'
                                            : '-${-value ~/ 1000}K',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 8,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      const labels = [
                                        '01/04/2022\n30/09/2022',
                                        '01/04/2023\n30/09/2023'
                                      ];
                                      return Text(
                                        labels[value.toInt()],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),

                              // borderData: FlBorderData(show: false),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide.none,
                                  left:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
            )),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final int x;
  final double y;
}
