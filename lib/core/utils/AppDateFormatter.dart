import 'package:intl/intl.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/models/EarlyBirdPeriod.dart';

import '../flavors_config/flavor_config.dart';

class AppDateFormatter {
  static const String apiDateTimeFormat = "yyyy-MM-ddThh:mm:ss.000Z";
  static const String shortDateFormat = "yyyy-MM-dd";
  static const String displayDateFormat = "dd MMM, yyyy";
  static const String timeFormat = "HH:mm";
  static const String longDateFormat = "dd MMMM yyyy";

  static DateTime? parseApiDateTime(String? date) {
    if (date == null || date.isEmpty) return null;
    try {
      return DateFormat(apiDateTimeFormat).parse(date);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static String formatAsApiDateTime(DateTime date) {
    return DateFormat(apiDateTimeFormat).format(date);
  }

  static DateTime? parseShortDate(String? date) {
    if (date == null || date.isEmpty) return null;
    try {
      return DateFormat(shortDateFormat).parse(date);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static String formatAsShortDate(DateTime date) {
    return DateFormat(shortDateFormat).format(date);
  }


  static String formatAsDisplayDate(DateTime date) {
    return DateFormat(displayDateFormat).format(date);
  }

  static String formatAsTime(DateTime date) {
    return DateFormat(timeFormat).format(date);
  }

  static String formatAsLongDate(DateTime date) {
    return DateFormat(longDateFormat).format(date);
  }

  static String? userMembershipExpiry(String? membershipExpiry) {
    Flavor flavor = FlavorConfig.instance.flavor!;

    if (flavor == Flavor.mhbc || flavor ==Flavor.maxClub) {
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

  static String? formatDateForEarlyBird(DateTime date) {
    try {
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static bool ifUserPurchasedMembership(
      {required String usersMembershipExpiry,
      required String membershipExpiry}) {
    try {
      AppHelper.printMessage("UsersMembershipExpiry: $usersMembershipExpiry --- MembershipExpiry: $membershipExpiry");
      DateFormat dateTimeFormat = DateFormat("yyyy-MM-ddThh:mm:ss.000Z");
      DateTime usersPlanExpiry = DateTime.parse(usersMembershipExpiry);
      DateTime planExpiry = DateTime.parse(membershipExpiry);

      return usersPlanExpiry.isAfter(planExpiry);
    } catch (e) {
      AppHelper.printMessage("ifUserPurchasedMembership: ${e.toString()}");
      return false;
    }
  }

  static bool isCurrentDateUnderEarlyBirdRange(
      {required EarlyBirdPeriod earlyBirdPeriod}) {
    try {
      AppHelper.printMessage("EarlyBirdPeriod: $earlyBirdPeriod");
      DateFormat dateTimeFormat = DateFormat("yyyy-MM-ddThh:mm:ss.000Z");
      DateTime rangeStartDate =
          dateTimeFormat.parse(earlyBirdPeriod.startDate!);
      DateTime rangeEndDate = dateTimeFormat.parse(earlyBirdPeriod.endDate!);
      DateTime today = DateTime.now();
      return ((today.isAfter(rangeStartDate) ||
              today.isAtSameMomentAs(rangeStartDate)) &&
          (today.isBefore(rangeEndDate) ||
              today.isAtSameMomentAs(rangeEndDate)));
    } catch (e) {
      return false;
    }
  }
}
