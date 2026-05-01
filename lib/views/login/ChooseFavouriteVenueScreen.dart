import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/views/common_widgets/AppCustomButton.dart';
import 'package:qantum_apps/views/common_widgets/AppLogo.dart';
import 'package:qantum_apps/views/common_widgets/AppScaffold.dart';

class Choosefavouritevenuescreen extends StatefulWidget {
  const Choosefavouritevenuescreen({super.key});

  @override
  State<Choosefavouritevenuescreen> createState() =>
      _ChoosefavouritevenuescreenState();
}

class _ChoosefavouritevenuescreenState
    extends State<Choosefavouritevenuescreen> {

  int selectedIndex = -1;

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
    return AppScaffold(
        body: SafeArea(
      child: Column(
        children: [
          Applogo(
            hideTopLine: true,
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
          Padding(
            padding:
            const EdgeInsets.only(left: 25.0, right: 25.0, top: 20),
            child: AppCustomButton(
              text: "Save My Venue",
              textColor: AppHelper.getAccountsButtonTextColor(context),
              onClick: () async {
                 AppNavigator.navigateAndClearStack(
                    context, AppNavigator.home);
              },
              style: AppHelper.getAccountsButtonStyle(context),
            ),
          )
        ],
      ),
    ));
  }
}
