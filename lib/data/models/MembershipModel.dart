class MembershipModel {
  String? id;
  String? membershipName;
  double? originalPrice;
  bool? proRataApplied;
  String? renewalDate;
  int? remainingDays;
  double? calculatedPrice;

  MembershipModel(
      {this.id,
      this.membershipName,
      this.originalPrice,
      this.proRataApplied,
      this.renewalDate,
      this.remainingDays,
      this.calculatedPrice});

  MembershipModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? "";
    membershipName = json["membershipName"] ?? "";
    originalPrice = (json["originalPrice"] != null)
        ? json["originalPrice"].toDouble()
        : 0.0;
    proRataApplied = json["proRataApplied"] ?? false;
    renewalDate = json["renewalDate"] ?? "";
    remainingDays = json["remainingDays"] ?? 0;
    calculatedPrice = (json["calculatedPrice"] != null)
        ? json["calculatedPrice"].toDouble()
        : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id ?? "";
    data["membershipName"] = membershipName ?? "";
    data["originalPrice"] = originalPrice ?? 0.0;
    data["proRataApplied"] = proRataApplied ?? false;
    data["renewalDate"] = renewalDate ?? "";
    data["remainingDays"] = remainingDays ?? 0;
    data["calculatedPrice"] = calculatedPrice ?? 0.0;
    return data;
  }
}
