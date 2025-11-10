import 'package:flutter/material.dart';

import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppIcons.dart';

class BottomInfoWidget extends StatelessWidget {
  String message;

  BottomInfoWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.lightBulb,
            width: 20,
            height: 20,
          ),
          AppDimens.shape_10,
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
          )
        ],
      ),
    );
  }
}
