import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppDimens.shape_20,
              Text(
                AppStrings.txtWelcome,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              AppDimens.shape_10,
              Text(
                AppStrings.txtEnterYourNumber,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              AppDimens.shape_10,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  maxLines: 1,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    counterStyle: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              AppDimens.shape_20,
              TextButton(
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).buttonTheme.colorScheme!.primary)),
                  onPressed: () {
                    AppNavigator.navigateTo(context, AppNavigator.signup);
                  },
                  child: Text(
                    AppStrings.txtOk,
                    style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
