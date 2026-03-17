import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';
import '../../../view_models/UnitedFuelsProvider.dart';
import '/core/utils/AppColors.dart';
import '/core/utils/AppDimens.dart';
import '/l10n/app_localizations.dart';
import '/views/common_widgets/AppButton.dart';
import '/views/partners_offer/widget/BarcodeView.dart';
import '/views/partners_offer/widget/UnitedTermsList.dart';
import '/views/partners_offer/widget/UnitedTopHeader.dart';
import '../../../core/navigation/AppNavigator.dart';
import '../../../core/utils/AppIcons.dart';

class UnitedFuelMainScreen extends StatefulWidget {
  const UnitedFuelMainScreen({super.key});

  @override
  State<UnitedFuelMainScreen> createState() => _UnitedFuelMainScreenState();
}

class _UnitedFuelMainScreenState extends State<UnitedFuelMainScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UnitedFuelsProvider>().loadBarcode(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              AppDimens.shape_10,
              UnitedTopHeader(),
              Expanded(child: Consumer<UnitedFuelsProvider>(
                  builder: (context, provider, child) {
                return Stack(
                  children: [
                    (provider.barcode != null && provider.barcode!.isNotEmpty)
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Save on fuels",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              AppNavigator.navigateTo(context,
                                                  AppNavigator.appWebView,
                                                  arguments:
                                                      "https://servicestations.unitedpetroleum.com.au/?fuelCards=acceptsUPDiscountFuelCards");
                                            },
                                            child: Text(
                                              "Find your nearest participating\nUnited service station",
                                              style: TextStyle(
                                                  color: AppColors.blue,
                                                  decorationColor:
                                                      AppColors.blue,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          )
                                        ],
                                      )),
                                      Image.asset(
                                        AppIcons.unitedFuelsRounded4c,
                                        width: 80,
                                        height: 80,
                                      )
                                    ],
                                  ),

                                  BarcodeView(
                                    alignment: BarcodeView.PORTRAIT,
                                  ),
                                  const UnitedTermsList()
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),

                    (provider.isError && provider.errorMessage.isNotEmpty)
                        ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(provider.errorMessage,style: TextStyle(color: AppColors.error_red,fontSize: 18,fontWeight: FontWeight.w300),),
                        ):const SizedBox.shrink(),


                    provider.isLoading ? AppLoader() : const SizedBox.shrink()
                  ],
                );
              })),
              SizedBox(
                width: 120,
                child: AppButton(
                    text: "DONE",
                    onClick: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ));
  }
}
