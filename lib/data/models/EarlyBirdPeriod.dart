class EarlyBirdPeriod {
  String? startDate;
  String? endDate;

  EarlyBirdPeriod({this.startDate, this.endDate});

  EarlyBirdPeriod.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
