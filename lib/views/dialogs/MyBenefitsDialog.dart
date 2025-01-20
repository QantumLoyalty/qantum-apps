import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../../core/utils/AppStrings.dart';
import '../../view_models/UserInfoProvider.dart';

class MyBenefitsDialog {
  static final MyBenefitsDialog _myBenefitsDialog =
      MyBenefitsDialog._internal();

  static MyBenefitsDialog getInstance() {
    return _myBenefitsDialog;
  }

  MyBenefitsDialog._internal();

  showBenefitsDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Consumer<UserInfoProvider>(
                    builder: (context, provider, child) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7 - 80,
                        child: Consumer<UserInfoProvider>(
                            builder: (context, provider, child) {
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  AppIcons.getCardBackground(
                                      provider.getUserInfo!.statusTier),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      provider.getUserInfo!.statusTier!
                                          .toUpperCase(),
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color: AppColors.black
                                                  .withValues(alpha: 0.5),
                                            )
                                          ],
                                          color: AppColors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      AppStrings.txtMembershipBenefits,
                                      style: TextStyle(shadows: [
                                        Shadow(
                                          offset: const Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: AppColors.black
                                              .withValues(alpha: 0.5),
                                        )
                                      ], color: AppColors.white, fontSize: 18),
                                    ),
                                    Expanded(
                                        child: Container(
                                      margin: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            minTileHeight: 10,
                                            leading: Icon(
                                              Icons.check_circle,
                                              color: AppColors
                                                  .getMembershipCategoryColor(
                                                      provider.getUserInfo!
                                                          .statusTier),
                                            ),
                                            title: Text('Benefits'),
                                          );
                                        },
                                        itemCount: 7,
                                      ),
                                    )),
                                    AppDimens.shape_20,
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 50,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage: ExactAssetImage(
                              AppIcons.getCardBackground(
                                  provider.getUserInfo!.statusTier),
                            ),
                            radius: 30,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  );
                }),
              ),
            ),
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
