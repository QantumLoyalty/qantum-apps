import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../view_models/SignupProvider.dart';

class GenderSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final textColor = Theme.of(context).textSelectionTheme.selectionColor;
    return Selector<SignupProvider, String>(
        selector: (_, signupProvider) => signupProvider.selectedGender ?? "",
        builder: (context, selectedGender, child) {
          final signupProvider =
              Provider.of<SignupProvider>(context, listen: false);
          return Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Radio<String>(
                        value: SignupProvider.male,
                        groupValue: selectedGender,
                        onChanged: (value) {
                          signupProvider.updateGender(value!);
                        }),
                    Text(
                      loc.txtMale,
                      style: TextStyle(color: textColor, fontSize: 12),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Radio<String>(
                      value: SignupProvider.female,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        signupProvider.updateGender(value!);
                      }),
                  Text(
                    loc.txtFemale,
                    style: TextStyle(color: textColor, fontSize: 12),
                  )
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Radio<String>(
                      value: SignupProvider.nonbinary,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        signupProvider.updateGender(value!);
                      }),
                  Expanded(
                    child: Text(
                      loc.txtNonBinary,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              )),
            ],
          );
        });
  }
}
