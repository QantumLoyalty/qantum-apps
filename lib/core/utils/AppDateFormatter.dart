import 'package:intl/intl.dart';

import '../flavors_config/flavor_config.dart';


class AppDateFormatter
{

  static String? userMembershipExpiry(String? membershipExpiry) {
    Flavor flavor = FlavorConfig.instance.flavor!;

    if (flavor == Flavor.mhbc) {
      if (membershipExpiry == null || membershipExpiry.isEmpty) return null;

      try {
        DateFormat dateTimeFormat = DateFormat("yyyy-MM-ddThh:mm:ss.000Z");
        DateFormat newDateTimeFormat = DateFormat("dd MMM, yyyy");
        return newDateTimeFormat
            .format((dateTimeFormat.parse(membershipExpiry)));
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }



}