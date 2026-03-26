import 'package:intl/intl.dart';
import 'package:qantum_apps/core/mixins/logging_mixin.dart';

import '../flavors_config/flavor_config.dart';
import '../mixins/logging_mixin.dart';

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

  static String? formatDateWithSuffix(DateTime membershipExpiry) {
    try {
      final day = membershipExpiry.day;
      final suffix = getDaySuffix(day);
      final monthYear = DateFormat('MMMM yyyy').format(membershipExpiry);
      return '$day$suffix $monthYear';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }



}
