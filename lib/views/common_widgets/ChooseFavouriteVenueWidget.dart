import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import '/core/utils/AppHelper.dart';
import '/l10n/app_localizations.dart';
import '/views/common_widgets/AppCustomButton.dart';
import '/views/common_widgets/AppLoader.dart';
import '../../core/extensions/spacer_extension.dart';
import '../../core/utils/AppIcons.dart';
import '../../view_models/UserInfoProvider.dart';

class ChooseFavouriteVenueWidget extends StatefulWidget {
  const ChooseFavouriteVenueWidget({super.key});

  @override
  State<ChooseFavouriteVenueWidget> createState() =>
      _ChooseFavouriteVenueWidgetState();
}

class _ChooseFavouriteVenueWidgetState
    extends State<ChooseFavouriteVenueWidget> {
  late AppLocalizations loc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<UserInfoProvider>().fetchVenueList();
    });
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context);
    final dialogHeight = media.size.height * 0.7;
    return Consumer<UserInfoProvider>(
        builder: (context, userInfoProvider, child) {
      if (userInfoProvider.errorOnSelectVenue != null) {
        if (!userInfoProvider.errorOnSelectVenue!) {
          Future.delayed(Duration.zero, () {
            Navigator.pop(context);
            userInfoProvider.resetErrorOnSelectVenue();
            AppHelper.showSuccessMessage(context, loc.selectVenuesSuccessMsg);
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            userInfoProvider.resetErrorOnSelectVenue();
          });
        }
      }

      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: dialogHeight,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none, // 🔥 IMPORTANT
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    width: media.size.width,
                    height: dialogHeight - 90,
                    child: Column(
                      children: [
                        Image.asset(
                          AppIcons.app_logo,
                          height: 100,
                          width: 140,
                        ),
                        Expanded(
                            child: Stack(
                          children: [
                            (userInfoProvider.venuesList != null &&
                                    userInfoProvider.venuesList!.isNotEmpty)
                                ? Column(
                                    children: [
                                      Text(
                                        loc.selectEDPVenues,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      20.h,
                                      Expanded(
                                          child: SingleChildScrollView(
                                              child: RadioGroup<String>(
                                        groupValue:
                                            userInfoProvider.selectedVenue,
                                        onChanged: (value) {
                                          userInfoProvider.selectVenue(value!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: userInfoProvider
                                                .venuesList!
                                                .map((item) {
                                              return RadioListTile<String>(
                                                  value: item.name!,
                                                  title: Text(item.name ?? "",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      )));
                                            }).toList(),
                                          ),
                                        ),
                                      ))),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            userInfoProvider.showVenuesListLoader != null &&
                                    userInfoProvider.showVenuesListLoader!
                                ? AppLoader()
                                : const SizedBox.shrink()
                          ],
                        )),
                        20.h,
                      ],
                    ),
                  ),

                  (userInfoProvider.errorOnSelectVenue != null &&
                          userInfoProvider.errorOnSelectVenue!)
                      ? Positioned(
                          left: 25,
                          right: 25,
                          bottom: 40,
                          child: Material(
                            color: AppColors.error_red,
                            child: Padding(
                              padding: const EdgeInsetsGeometry.all(10),
                              child: Text(
                                "Error while updating the venue",
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ))
                      : const SizedBox.shrink(),

                  /// CLOSE BUTTON
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: -20,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
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
              ),
              5.h, // 🔥 ADD THIS
              (userInfoProvider.venuesList != null &&
                      userInfoProvider.venuesList!.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20),
                      child: AppCustomButton(
                        text: loc.txtSaveMyVenue.toString(),
                        textColor:
                            AppHelper.getAccountsButtonTextColor(context),
                        onClick: () async {
                          if (userInfoProvider.selectedVenue != null &&
                              userInfoProvider.selectedVenue!.isNotEmpty) {
                            userInfoProvider.updateSelectedVenue();
                          }
                        },
                        style: AppHelper.getAccountsButtonStyle(context),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      );
    });
  }
}
