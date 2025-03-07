import 'package:flutter/material.dart';

import '../../../core/utils/AppIcons.dart';

class PromotionsPlaceHolder extends StatelessWidget {
  final Size size;

  const PromotionsPlaceHolder({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Card(
          color: Theme.of(context).cardColor,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(AppIcons.app_logo))),
    );
  }
}
