import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
  UserStatusTier({super.key});

  late AppLocalizations loc;
  num statusPoints = 0;
  late Flavor flavor;

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    flavor = FlavorConfig.instance.flavor!;

    List<String> statusCreditMsg =
        loc.txtStatusCreditsReactNextLevel.split("###");

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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "${statusCreditMsg[0].toUpperCase()}\n",
                    style: TextStyle(
                        color: AppThemeCustom
                            .getProfileDialogUserStatusTierTextColor(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                TextSpan(
                    text: statusCreditMsg[1].toUpperCase(),
                    style: TextStyle(
                        color: AppThemeCustom
                            .getProfileDialogUserStatusTierTextColor(context),
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
              ]),
            ),
            20.h,
            SizedBox(
              height: 180,
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
                                fontSize: 24)),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'of ${provider.getUserInfo != null ? ((provider.getUserInfo!.requiredStatusPointsForNextTier ?? 0)) : "-"}',
                                style: TextStyle(
                                    color: AppThemeCustom
                                        .getProfileDialogUserStatusTierTextColor(
                                            context),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20)),
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
            AppDimens.shape_15,
            (flavor == Flavor.mhbc)
                ? const SizedBox.shrink()
                : (flavor == Flavor.starReward
                    ? /*RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "311 ",
                              style: TextStyle(
                                  color: AppThemeCustom
                                      .getProfileDialogUserStatusTierTextColor(
                                          context),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          TextSpan(
                              text: "Status credits required\nto maintain current level",
                              style: TextStyle(
                                  color: AppThemeCustom
                                      .getProfileDialogUserStatusTierTextColor(
                                          context),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ]),
                      )*/
                    (provider.statusTierValue.isNotEmpty
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${provider.statusTierValue} ",
                                style: TextStyle(
                                    color: AppThemeCustom
                                        .getProfileDialogUserStatusTierTextColor(
                                            context),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                "Status Credits required\nto maintain current level",
                                style: TextStyle(
                                    height: 1.1,
                                    color: AppThemeCustom
                                        .getProfileDialogUserStatusTierTextColor(
                                            context),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                            ],
                          )
                        : SizedBox.shrink())
                    : Text(
                        loc.txtHowToEarnStatusCredits,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppThemeCustom
                                .getProfileDialogUserStatusTierTextColor(
                                    context),
                            fontSize: 13),
                      )),
            AppDimens.shape_15,
          ],
        ),
      );
    });
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
