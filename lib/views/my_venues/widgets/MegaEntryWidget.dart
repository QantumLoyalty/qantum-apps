import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/extensions/spacer_extension.dart';
import '/view_models/UserInfoProvider.dart';

import '../../../core/flavors_config/flavor_config.dart';

class MegaEntryWidget extends StatelessWidget {
  const MegaEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      if (FlavorConfig.instance.flavor == Flavor.starReward &&
          provider.getUserInfo != null &&
          provider.getUserInfo!.membersDrawEntries != null &&
          provider.getUserInfo!.membersDrawEntries! > 0) {
        return Container(
          padding: const EdgeInsetsGeometry.all(15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You have",
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor)),
              5.h,
              Text(
                "${provider.getUserInfo!.membersDrawEntries!}",
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.bold),
              ),
              5.h,
              Text("Mega Draw Entries",
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor)),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
