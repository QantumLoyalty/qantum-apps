import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
            AppDimens.shape_15,
            Text(
              loc.txtStatusCreditsReactNextLevel.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppThemeCustom.getProfileDialogTextColor(context),
                  fontSize: 13),
            ),
            AppDimens.shape_15,
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //   statusPoints != 0 ?
                        Countup(
                            begin: 0,
                            end: (provider.getUserInfo != null &&
                                    provider.getUserInfo!.statusPoints != null)
                                ? provider.getUserInfo!.statusPoints!.toDouble()
                                : 0,
                            duration: const Duration(seconds: 1),
                            style: TextStyle(
                                color: AppThemeCustom.getProfileDialogTextColor(
                                    context),
                                fontWeight: FontWeight.w900,
                                fontSize: 24)),
                        //: Container(),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            //    if(statusPoints != 0)
                            TextSpan(
                                text:
                                    'of ${provider.getUserInfo != null ? ((provider.getUserInfo!.statusPoints ?? 0) + (provider.getUserInfo!.requiredStatusPointsForNextTier ?? 0)) : "-"}',
                                style: TextStyle(
                                    color: AppThemeCustom
                                        .getProfileDialogTextColor(context),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20)),
                            TextSpan(
                                text:
                                    '\n\nStatus credits required\nto advance to ${provider.getUserInfo != null ? provider.getUserInfo!.nextStatusTier ?? "" : ""}'
                                        .toUpperCase(),
                                style: TextStyle(
                                    color: AppThemeCustom
                                        .getProfileDialogTextColor(context),
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
                : Text(
                    loc.txtHowToEarnStatusCredits,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            AppThemeCustom.getProfileDialogTextColor(context),
                        fontSize: 13),
                  ),
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
