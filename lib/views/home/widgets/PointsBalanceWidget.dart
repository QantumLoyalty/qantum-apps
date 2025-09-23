import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    Provider.of<UserInfoProvider>(context, listen: false).fetchUserPoints();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.txtPointsBalance.toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    formatPoints((provider.getUserInfo!.pointsValue ?? 0)),
                    //formatPoints(500000),
                    style: TextStyle(
                        fontSize: 42,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$${formatPointsValue((provider.getUserInfo!.pointsBalance ?? 0))}",
                    style: TextStyle(
                        fontSize: 12, color: AppThemeCustom.getPointsBalanceTextColor(context)),
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
    return formatter.format(points.toInt());
  }

  String formatPointsValue(num pointsValue) {
    var formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(pointsValue);
  }
}
