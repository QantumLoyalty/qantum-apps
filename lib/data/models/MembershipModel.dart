import 'EarlyBirdPeriod.dart';

class MembershipModel {
  String? id;
  String? membershipName;
  double? originalPrice;
  bool? proRataApplied;
  String? renewalDate;
  int? remainingDays;
  double? calculatedPrice;
  String? earlyBirdRenewalDate;
  EarlyBirdPeriod? earlyBirdPeriod;

  MembershipModel(
      {this.id,
      this.membershipName,
      this.originalPrice,
      this.proRataApplied,
      this.renewalDate,
      this.remainingDays,
      this.calculatedPrice,
      this.earlyBirdPeriod});

  MembershipModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? "";
    membershipName = json["membershipName"] ?? "";
    if (json["originalPrice"] != null) {
      originalPrice = json["originalPrice"].toDouble();
    } else if (json["price"] != null) {
      originalPrice = json["price"].toDouble();
    } else {
      originalPrice = 0.0;
    }

    proRataApplied = json["proRataApplied"] ?? false;
    renewalDate = json["renewalDate"] ?? "";
    remainingDays = json["remainingDays"] ?? 0;
    calculatedPrice = (json["calculatedPrice"] != null)
        ? json["calculatedPrice"].toDouble()
        : 0.0;
    earlyBirdPeriod = json['earlyBirdPeriod'] != null
        ? EarlyBirdPeriod.fromJson(json['earlyBirdPeriod'])
        : null;
    earlyBirdRenewalDate = json['earlyBirdRenewalDate'];
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
    if (earlyBirdPeriod != null) {
      data['earlyBirdPeriod'] = earlyBirdPeriod!.toJson();
    }
    data['earlyBirdRenewalDate'] = earlyBirdRenewalDate;
    return data;
  }

  @override
  String toString() {
    return 'MembershipModel{id: $id, membershipName: $membershipName, originalPrice: $originalPrice, proRataApplied: $proRataApplied, renewalDate: $renewalDate, remainingDays: $remainingDays, calculatedPrice: $calculatedPrice, earlyBirdRenewalDate: $earlyBirdRenewalDate, earlyBirdPeriod: $earlyBirdPeriod}';
  }
}
