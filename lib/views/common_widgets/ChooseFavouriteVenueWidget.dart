import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import 'package:qantum_apps/views/common_widgets/AppCustomButton.dart';

import '../../core/utils/AppColors.dart' show AppColors;
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
  int selectedIndex = -1;
  late AppLocalizations loc;

  final List<String> venues = [
    "Bridgeport Hotel",
    "Carlisle Tavern",
    "Gray’s Inn",
    "Hotel Bayview",
    "Little Pub",
    "Portland Hotel",
    "Pulteney Pokies"
  ];

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context);
    final dialogHeight = media.size.height * 0.7;
    return Consumer<UserInfoProvider>(
        builder: (context, userInfoProvider, child) {
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
                        Text(
                          "Please choose your\nfavourite EDP Venues",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).textSelectionTheme.selectionColor,
                            fontSize: 20,
                          ),
                        ),


                        /// ✅ FIX: Wrap with Expanded
                        Expanded(
                          child: ListView.builder(
                            itemCount: venues.length,
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            itemBuilder: (context, index) {
                              return RadioListTile<int>(
                                contentPadding: EdgeInsets.zero,
                                value: index,
                                dense: true, // 🔥 reduces height
                                visualDensity: const VisualDensity(vertical: -1), // 🔥 tighter spacing
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔥 removes default touch padding
                                groupValue: selectedIndex,
                                onChanged: (val) {
                                  setState(() {
                                    selectedIndex = val!;
                                  });
                                },
                                title: Text(
                                  venues[index],
                                  style: TextStyle( color: Theme.of(context).textSelectionTheme.selectionColor,),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

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
              const SizedBox(height: 5), // 🔥 ADD THIS
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 20),
                child: AppCustomButton(
                  text: loc.txtSaveMyVenue.toString(),
                  textColor: AppHelper.getAccountsButtonTextColor(context),
                  onClick: () async {},
                  style: AppHelper.getAccountsButtonStyle(context),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
