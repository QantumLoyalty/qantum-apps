import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qantum_apps/views/common_widgets/ChooseFavouriteVenueWidget.dart';

class ChooseFavouriteVenuedialog {
  static final ChooseFavouriteVenuedialog _chooseFavouriteVenuedialog =
  ChooseFavouriteVenuedialog._internal();

  static ChooseFavouriteVenuedialog getInstance() {
    return _chooseFavouriteVenuedialog;
  }

  ChooseFavouriteVenuedialog._internal();

  showChooseFavouriteVenueDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: ChooseFavouriteVenueWidget(),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
            child: SlideTransition(
              position:
                  Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child,
            ),
          );
        });
  }
}
