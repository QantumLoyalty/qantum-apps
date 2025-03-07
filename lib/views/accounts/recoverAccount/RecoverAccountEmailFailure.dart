import 'package:flutter/material.dart';
import '/views/common_widgets/AppScaffold.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppStrings.dart';
import '../../common_widgets/AppLogo.dart';

class RecoverAccountEmailFailure extends StatelessWidget {
  const RecoverAccountEmailFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Applogo(
              hideTopLine: true,
            ),
            Text(
              AppStrings.txtThereWasError,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            AppDimens.shape_5,
            Text(
              AppStrings.msgRecoverEmailError,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            AppDimens.shape_40,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                  style: ButtonStyle(
                      side: WidgetStatePropertyAll(BorderSide(
                    width: 1.5,
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                  ))),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(AppStrings.txtContactVenueSupport.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary,
                        )),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
