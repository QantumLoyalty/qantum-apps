import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/flavors_config/app_theme_custom.dart';
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          toY: 87204.9,
          color: Colors.lightBlueAccent,
          width: 30,
        ),
        BarChartRodData(
          borderRadius: const BorderRadius.only(
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
    AppLocalizations loc = AppLocalizations.of(context)!;

    return AppScaffold(
      scaffoldBackground: AppThemeCustom.getAccountBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(showBackButton: true, title: loc.txtPASStatement),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context).canvasColor,
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  AppDimens.shape_20,
                  Text(loc.txtPlayerActivityStatementFor,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppThemeCustom.getAccountSectionItemStyle(context))),
                  Text(
                    "(1 Jul 2023 ${loc.txtTo} 30 September 2023)",
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            AppThemeCustom.getAccountSectionItemStyle(context)!
                                .withValues(alpha: 0.7)),
                  ),
                  AppDimens.shape_20,
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.txtDetails,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:  AppThemeCustom.getAccountSectionItemStyle(context)),
                        ),
                        AppDimens.shape_10,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${loc.txtCard} #",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeCustom.getAccountSectionItemStyle(context)),
                              ),
                            ),
                            AppDimens.shape_20,
                            Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppThemeCustom.getAccountSectionItemStyle(context)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                loc.txtTotalAmountBet,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeCustom.getAccountSectionItemStyle(context)),
                              ),
                            ),
                            AppDimens.shape_20,
                            Text(
                              "\$10000",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppThemeCustom.getAccountSectionItemStyle(context)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                loc.txtTotalAmountWon,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeCustom.getAccountSectionItemStyle(context)),
                              ),
                            ),
                            AppDimens.shape_20,
                            Text(
                              "\$10000",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppThemeCustom.getAccountSectionItemStyle(context)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                loc.txtNetAmountWonOrLost,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeCustom.getAccountSectionItemStyle(context)),
                              ),
                            ),
                            AppDimens.shape_20,
                            Text(
                              "\$10000",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppThemeCustom.getAccountSectionItemStyle(context)),
                            )
                          ],
                        ),
                        AppDimens.shape_10,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                loc.txtTotalDaysPlayed,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeCustom.getAccountSectionItemStyle(context)),
                              ),
                            ),
                            AppDimens.shape_20,
                            Text(
                              "30",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppThemeCustom.getAccountSectionItemStyle(context)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                loc.txtTotalHoursPlayed,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppThemeCustom.getAccountSectionItemStyle(context)),
                              ),
                            ),
                            AppDimens.shape_20,
                            Text(
                              "20",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppThemeCustom.getAccountSectionItemStyle(context)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppDimens.shape_20,
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8)),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.txtPerformance,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppThemeCustom.getAccountSectionItemStyle(context)),
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
                                        color: AppThemeCustom.getAccountSectionItemStyle(context),
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
                                      style:  TextStyle(
                                        color: AppThemeCustom.getAccountSectionItemStyle(context),
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
                                left: BorderSide(color: Colors.white, width: 1),
                              ),
                            ),
                          )),
                        )
                      ],
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
