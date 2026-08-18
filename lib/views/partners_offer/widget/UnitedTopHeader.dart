import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppIcons.dart';

class UnitedTopHeader extends StatelessWidget {
  late Size mSize;

  UnitedTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    mSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// UNITED FUEL LOGO
        Image.asset(
          AppIcons.unitedFuelsBanner,
          width: mSize.width,
          height: 24,
          fit: BoxFit.contain,
        ),
        AppDimens.shape_15,

        /// UNITED FUEL HERO IMAGE
        SizedBox(
          width: mSize.width,
          height: 160,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppIcons.unitedFuelsHero,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
