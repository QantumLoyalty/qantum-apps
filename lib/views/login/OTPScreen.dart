import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qantum_apps/views/common_widgets/AppButton.dart';

import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppDimens.shape_30,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: AppDimens.appBarHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 1,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(

                            counter: AppDimens.shape_5,
                            fillColor: Theme.of(context).cardColor,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counter: AppDimens.shape_5,
                            fillColor: Theme.of(context).cardColor,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 1,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counter: AppDimens.shape_5,
                            fillColor: Theme.of(context).cardColor,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 1,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counter: AppDimens.shape_5,
                            fillColor: Theme.of(context).cardColor,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppDimens.shape_20,
              Text(
                AppStrings.msgEnterVerificationCode,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              AppDimens.shape_20,

              AppButton(text: AppStrings.txtSubmit, onClick: () {
                AppNavigator.navigateTo(context, AppNavigator.home);
              }),


            ],
          ),
        ),
      ),
    );
  }
}
