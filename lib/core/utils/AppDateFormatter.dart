import 'package:intl/intl.dart';

import '../flavors_config/flavor_config.dart';

class AppDateFormatter {
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

  static String? dobForClevaQ(String? dob) {
    if (dob == null) return null;

    try {
      final parsedDob = DateTime.parse(dob);

      final year = parsedDob.year % 100; // last 2 digits
      return "${parsedDob.day.toString().padLeft(2, '0')}"
          "${parsedDob.month.toString().padLeft(2, '0')}"
          "${year.toString().padLeft(2, '0')}";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
