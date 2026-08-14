import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import '../../core/extensions/spacer_extension.dart';
import '../../core/flavors_config/flavor_config.dart';
import '/core/mixins/logging_mixin.dart';
import '/l10n/app_localizations.dart';
import '/view_models/UserInfoProvider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';

class UserStatusTier extends StatelessWidget with LoggingMixin {
  late AppLocalizations loc;
  num statusPoints = 0;
  @override
  late Flavor flavor;
  bool? isSmallScreen;

  UserStatusTier({super.key, this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    flavor = FlavorConfig.instance.flavor!;
    "isSmallScreen:$isSmallScreen".logMessage();
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      statusPoints = (provider.getUserInfo != null &&
              provider.getUserInfo!.statusPoints != null)
          ? provider.getUserInfo!.statusPoints!
          : 0;

      return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppDimens.shape_5,
            /*flavor == Flavor.starReward || flavor == Flavor.flinders
                ?*/
            (provider.showNextLevel
                ? dialerWidget(context, provider)
                : const SizedBox(
                    height: 200,
                  )),
            /*: dialerWidget(context, provider),*/
            AppDimens.shape_15,
            (flavor == Flavor.mhbc ||
                    flavor == Flavor.starReward ||
                    flavor == Flavor.flinders ||
                    flavor == Flavor.edp ||
                    flavor == Flavor.qantum ||
                    flavor == Flavor.qantumClub ||
                    flavor == Flavor.mannumClub ||
                    flavor == Flavor.maxClub ||
                    flavor == Flavor.maxx ||
                    flavor == Flavor.hogansReward
                ? statusTierWidget(context, provider)
                : Text(
                    loc.txtHowToEarnStatusCredits,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppThemeCustom
                            .getProfileDialogUserStatusTierTextColor(context),
                        fontSize: 13),
                  )),
            AppDimens.shape_15,
          ],
        ),
      );
    });
  }

  Widget dialerWidget(BuildContext context, UserInfoProvider provider) {
    List<String> statusCreditMsg =
        loc.txtStatusCreditsReactNextLevel.split("###");

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "${statusCreditMsg[0].toUpperCase()}\n",
                style: TextStyle(
                    color:
                        AppThemeCustom.getProfileDialogUserStatusTierTextColor(
                            context),
                    fontWeight: FontWeight.bold,
                    fontSize:
                        isSmallScreen != null && isSmallScreen! ? 16 : 20)),
            TextSpan(
                text: statusCreditMsg[1].toUpperCase(),
                style: TextStyle(
                    color:
                        AppThemeCustom.getProfileDialogUserStatusTierTextColor(
                            context),
                    fontWeight: FontWeight.w400,
                    fontSize:
                        isSmallScreen != null && isSmallScreen! ? 12 : 14)),
          ]),
        ),
        20.h,
        SizedBox(
          height: isSmallScreen != null && isSmallScreen! ? 150 : 180,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Countup(
                        begin: 0,
                        end: (provider.getUserInfo != null &&
                                provider.getUserInfo!.statusPoints != null)
                            ? provider.getUserInfo!.statusPoints!.toDouble()
                            : 0,
                        duration: const Duration(seconds: 1),
                        style: TextStyle(
                            color: AppThemeCustom
                                .getProfileDialogUserStatusTierTextColor(
                                    context),
                            fontWeight: FontWeight.w900,
                            fontSize: isSmallScreen != null && isSmallScreen!
                                ? 18
                                : 24)),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                'of ${provider.getUserInfo != null ? ((provider.getUserInfo!.statusPoints ?? 0) + (provider.getUserInfo!.requiredStatusPointsForNextTier ?? 0)) : "-"}',
                            style: TextStyle(
                                color: AppThemeCustom
                                    .getProfileDialogUserStatusTierTextColor(
                                        context),
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    isSmallScreen != null && isSmallScreen!
                                        ? 14
                                        : 20)),
                        TextSpan(
                            text:
                                '\n\n${loc.txtStatusCreditsRequiredReactNextLevel}'
                                    .toUpperCase(),
                            style: TextStyle(
                                color: AppThemeCustom
                                    .getProfileDialogUserStatusTierTextColor(
                                        context),
                                fontWeight: FontWeight.w400,
                                fontSize: 8)),
                      ]),
                    ),
                  ],
                ),
              ),
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: AxisLineStyle(
                        thickness: 0.05,
                        color: AppColors.white,
                        thicknessUnit: GaugeSizeUnit.factor,
                        dashArray: const <double>[3, 3]),
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        enableAnimation: false,
                        value: 0,
                        markerWidth: 20,
                        markerHeight: 20,
                        markerType: MarkerType.circle,
                        color: AppColors.white,
                      ),
                      RangePointer(
                        value: getCircularGraphValue(
                            provider.getUserInfo != null
                                ? provider.getUserInfo!.statusPoints
                                : 0,
                            provider.getUserInfo != null
                                ? provider.getUserInfo!
                                    .requiredStatusPointsForNextTier
                                : 0),
                        width: 0.05,
                        sizeUnit: GaugeSizeUnit.factor,
                        cornerStyle: CornerStyle.startCurve,
                        enableAnimation: true,
                        color: AppColors.white,
                      ),
                      if (provider.getUserInfo != null &&
                          provider.getUserInfo!.statusPoints != null &&
                          provider.getUserInfo!.statusPoints! > 5)
                        MarkerPointer(
                          enableAnimation: true,
                          value: getCircularGraphValue(
                              provider.getUserInfo != null
                                  ? provider.getUserInfo!.statusPoints
                                  : 0,
                              provider.getUserInfo != null
                                  ? provider.getUserInfo!
                                      .requiredStatusPointsForNextTier
                                  : 0),
                          markerWidth: 25,
                          markerHeight: 25,
                          markerType: MarkerType.image,
                          color: (provider.getUserInfo != null &&
                                  provider.getUserInfo!.statusPoints != null)
                              ? AppColors.white
                              : Colors.transparent,
                          imageUrl: 'assets/common/play.png',
                        )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget statusTierWidget(BuildContext context, UserInfoProvider provider) {
    return (provider.statusTierValue.isNotEmpty && provider.showStatusCredit
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${provider.statusTierValue} ",
                    style: TextStyle(
                        color: AppThemeCustom
                            .getProfileDialogUserStatusTierTextColor(context),
                        fontWeight: FontWeight.bold,
                        fontSize:
                            isSmallScreen != null && isSmallScreen! ? 24 : 30),
                  ),
                  Text(
                    "Status Credits required\nto maintain current level",
                    style: TextStyle(
                        height: 1.1,
                        color: AppThemeCustom
                            .getProfileDialogUserStatusTierTextColor(context),
                        fontWeight: FontWeight.normal,
                        fontSize:
                            isSmallScreen != null && isSmallScreen! ? 12 : 14),
                  ),
                ],
              ),
              5.h,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "You have ",
                      style: TextStyle(
                          color: AppThemeCustom
                              .getProfileDialogUserStatusTierTextColor(context),
                          fontWeight: FontWeight.normal,
                          fontSize: 14)),
                  TextSpan(
                      text:
                          "${provider.getUserInfo != null ? provider.getUserInfo!.statusPoints ?? 0 : 0}",
                      style: TextStyle(
                          color: AppThemeCustom
                              .getProfileDialogUserStatusTierTextColor(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  TextSpan(
                      text: " Status Credits",
                      style: TextStyle(
                          color: AppThemeCustom
                              .getProfileDialogUserStatusTierTextColor(context),
                          fontWeight: FontWeight.normal,
                          fontSize: 14)),
                ]),
              ),
            ],
          )
        : const SizedBox.shrink());
  }

  double getCircularGraphValue(num? currentPoint, num? requiredPoints) {
    logEvent(
        "Current Point --> $currentPoint Required Point --> $requiredPoints");
    if (currentPoint != null && requiredPoints != null) {
      return (currentPoint / (currentPoint + requiredPoints)) * 100;
    }
    return 0;
  }
}
