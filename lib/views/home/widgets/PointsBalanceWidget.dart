import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import '/l10n/app_localizations.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../view_models/UserInfoProvider.dart';

class PointsBalanceWidget extends StatefulWidget {
  const PointsBalanceWidget({super.key});

  @override
  State<PointsBalanceWidget> createState() => _PointsBalanceWidgetState();
}

class _PointsBalanceWidgetState extends State<PointsBalanceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    Provider.of<UserInfoProvider>(context, listen: false).checkInternetStatus();

    // _controller.forward(); // start fade out
  }

  @override
  void dispose() {
    _controller.reverse().then((_) {
      _controller.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: AnimatedOpacity(
        opacity: _fadeAnim.value,
        duration: const Duration(seconds: 1),
        child: Card(
          elevation: 10,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppThemeCustom.getPointsBalanceBackground(context),
                border: Border.all(
                    color: AppThemeCustom.getPointsBalanceBorder(context)),
                borderRadius: BorderRadius.circular(10)),
            child:
                Consumer<UserInfoProvider>(builder: (context, provider, child) {
              return (provider.internetStatus != null)
                  ? provider.internetStatus!
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .txtPointsBalance
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      AppThemeCustom.getPointsBalanceTextColor(
                                          context),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              formatPoints(
                                  (provider.getUserInfo!.pointsValue ?? 0)),


                              style: TextStyle(
                                  fontSize: 42,
                                  color:
                                      AppThemeCustom.getPointsBalanceTextColor(
                                          context),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "\$${formatPointsValue((provider.getUserInfo!.pointsBalance ?? 0))}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppThemeCustom
                                      .getPointsBalancePointTextColor(context)),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .txtPointsBalance
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      AppThemeCustom.getPointsBalanceTextColor(
                                          context),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppLocalizations.of(context)!.unavailable,
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      AppThemeCustom.getPointsBalanceTextColor(
                                          context),
                                  fontWeight: FontWeight.w500),
                            ),
                            AppDimens.shape_10,
                            Text(
                              AppLocalizations.of(context)!.msgNoInternet,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppThemeCustom.getPointsBalanceTextColor(
                                    context),
                              ),
                            ),
                          ],
                        )
                  : const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 16,

                        ),
                        AppDimens.shape_10,
                        SizedBox(
                          width: 180,
                          height: 42,

                        ),
                        AppDimens.shape_10,
                        SizedBox(
                          width: 180,
                          height: 12,

                        ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  String formatPoints(num points) {

    var formatter = NumberFormat("#,##0", "en_US");
  /*  return formatter.format(points.toInt());*/
// Truncate instead of round
    final truncated = points.truncate();

    return formatter.format(truncated);

  }

  String formatPointsValue(num pointsValue) {
    var formatter = NumberFormat("#,##0.00", "en_US");
   // return formatter.format(pointsValue.truncate());
    // Truncate to 2 decimal places instead of rounding
    final truncated =
        (pointsValue * 100).truncateToDouble() / 100;

    return formatter.format(truncated);

  }
}
