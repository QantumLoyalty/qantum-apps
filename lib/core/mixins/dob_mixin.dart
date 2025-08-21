mixin DOBMixin {
  bool verifyDOB(
      {required String date, required String month, required String year}) {
    if (date.isNotEmpty && month.isNotEmpty && year.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime dob = DateTime(
        int.parse(year),
        int.parse(month),
        int.parse(date),
      );

      if (dob.isBefore(DateTime.now())) {
        print("TODAY: $now --> DOB: $dob");

        int age = now.year - dob.year;

        // If birthday hasn’t occurred yet this year, subtract 1
        if (now.month < dob.month ||
            (now.month == dob.month && now.day < dob.day)) {
          age--;
        }

        print("AGE RESULT :: $age");

        return age >= 18;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
