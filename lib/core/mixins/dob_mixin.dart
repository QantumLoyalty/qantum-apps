mixin DOBMixin {
  bool verifyDOB({required String date,required String month, required String year}) {
    if (date.isNotEmpty && month.isNotEmpty && year.isNotEmpty) {
      DateTime dateTime =
          DateTime(int.parse(year), int.parse(month), int.parse(date));

      return dateTime.isBefore(DateTime.now()) &&
          (DateTime.now().difference(dateTime).inDays ~/ 365) > 18;
    } else {
      return false;
    }
  }
}
