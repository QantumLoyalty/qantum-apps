import 'package:flutter/material.dart';
import '/core/utils/AppColors.dart';
import '/core/utils/AppDimens.dart';
import '/l10n/app_localizations.dart';

class AppLoader extends StatelessWidget {
  String? loaderMessage;

   AppLoader({super.key,this.loaderMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
                AppDimens.shape_15,
                Text(
                  loaderMessage??AppLocalizations.of(context)!.txtLoading,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            )),
      ),
    );
  }
}
