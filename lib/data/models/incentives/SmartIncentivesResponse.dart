
class SmartIncentiveResponse {
  final bool success;
  final String message;
  final IncentiveUser? user;
  List<String>? requestAudience;
  List<MatchedIncentive>? matchedIncentives;
  List<AlreadyIssuedIncentive>? alreadyIssuedIncentives;
  List<dynamic>? notMatchedIncentives;

  SmartIncentiveResponse({
    required this.success,
    required this.message,
    required this.user,
    required this.requestAudience,
    required this.matchedIncentives,
    required this.alreadyIssuedIncentives,
    required this.notMatchedIncentives,
  });

  factory SmartIncentiveResponse.fromJson(Map<String, dynamic> json) {
    return SmartIncentiveResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: IncentiveUser.fromJson(json['user'] ?? {}),
      requestAudience: List<String>.from(json['requestAudience'] ?? []),
      matchedIncentives: (json['matchedIncentives'] as List? ?? [])
          .map((i) => MatchedIncentive.fromJson(i))
          .toList(),
      alreadyIssuedIncentives: (json['alreadyIssuedIncentives'] as List? ?? [])
          .map((i) => AlreadyIssuedIncentive.fromJson(i))
          .toList(),
      notMatchedIncentives:
          List<dynamic>.from(json['notMatchedIncentives'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user?.toJson(),
      'requestAudience': requestAudience,
      'matchedIncentives': matchedIncentives?.map((i) => i.toJson()).toList(),
      'alreadyIssuedIncentives': alreadyIssuedIncentives?.map((i) => i.toJson()).toList(),
      'notMatchedIncentives': notMatchedIncentives,
    };
  }
}

class IncentiveUser {
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String membershipType;
  final String membershipCategory;
  final String statusTier;
  final String cardNumber;
  final double pointsBalance;

  IncentiveUser({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.membershipType,
    required this.membershipCategory,
    required this.statusTier,
    required this.cardNumber,
    required this.pointsBalance,
  });

  factory IncentiveUser.fromJson(Map<String, dynamic> json) {
    return IncentiveUser(
      id: json['Id'] ?? '',
      // Handles case matching the API payload string keys
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      membershipType: json['MembershipType'] ?? '',
      membershipCategory: json['MembershipCategory'] ?? '',
      statusTier: json['StatusTier'] ?? '',
      cardNumber: json['CardNumber'] ?? '',
      pointsBalance: (json['PointsBalance'] as num? ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'MembershipType': membershipType,
      'MembershipCategory': membershipCategory,
      'StatusTier': statusTier,
      'CardNumber': cardNumber,
      'PointsBalance': pointsBalance,
    };
  }
}

class MatchedIncentive {
  final String incentiveId;
  final String offerType;
  final String deliveryMethod;
  final List<String> audience;
  final List<String> requestAudience;
  final String triggerType;
  final String timePeriod;
  final String matchedField;
  final num userFieldValue;
  final num triggerValue;
  final num incentiveValue;
  final num pointsToAdd;
  final num budgetRemaining;
  final String message;

  MatchedIncentive({
    required this.incentiveId,
    required this.offerType,
    required this.deliveryMethod,
    required this.audience,
    required this.requestAudience,
    required this.triggerType,
    required this.timePeriod,
    required this.matchedField,
    required this.userFieldValue,
    required this.triggerValue,
    required this.incentiveValue,
    required this.pointsToAdd,
    required this.budgetRemaining,
    required this.message,
  });

  factory MatchedIncentive.fromJson(Map<String, dynamic> json) {
    return MatchedIncentive(
      incentiveId: json['incentiveId'] ?? '',
      offerType: json['offerType'] ?? '',
      deliveryMethod: json['deliveryMethod'] ?? '',
      audience: List<String>.from(json['audience'] ?? []),
      requestAudience: List<String>.from(json['requestAudience'] ?? []),
      triggerType: json['triggerType'] ?? '',
      timePeriod: json['timePeriod'] ?? '',
      matchedField: json['matchedField'] ?? '',
      userFieldValue: json['userFieldValue'] ?? 0,
      triggerValue: json['triggerValue'] ?? 0,
      incentiveValue: json['incentiveValue'] ?? 0,
      pointsToAdd: json['pointsToAdd'] ?? 0,
      budgetRemaining: json['budgetRemaining'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'incentiveId': incentiveId,
      'offerType': offerType,
      'deliveryMethod': deliveryMethod,
      'audience': audience,
      'requestAudience': requestAudience,
      'triggerType': triggerType,
      'timePeriod': timePeriod,
      'matchedField': matchedField,
      'userFieldValue': userFieldValue,
      'triggerValue': triggerValue,
      'incentiveValue': incentiveValue,
      'pointsToAdd': pointsToAdd,
      'budgetRemaining': budgetRemaining,
      'message': message,
    };
  }
}

class AlreadyIssuedIncentive {
  final String incentiveId;
  final String offerType;
  final String deliveryMethod;
  final List<String> audience;
  final String triggerType;
  final String timePeriod;
  final String issuedAt;
  final String issuedDateBrisbane;
  final String message;

  AlreadyIssuedIncentive({
    required this.incentiveId,
    required this.offerType,
    required this.deliveryMethod,
    required this.audience,
    required this.triggerType,
    required this.timePeriod,
    required this.issuedAt,
    required this.issuedDateBrisbane,
    required this.message,
  });

  factory AlreadyIssuedIncentive.fromJson(Map<String, dynamic> json) {
    return AlreadyIssuedIncentive(
      incentiveId: json['incentiveId'] ?? '',
      offerType: json['offerType'] ?? '',
      deliveryMethod: json['deliveryMethod'] ?? '',
      audience: List<String>.from(json['audience'] ?? []),
      triggerType: json['triggerType'] ?? '',
      timePeriod: json['timePeriod'] ?? '',
      issuedAt: json['issuedAt'] ?? '',
      issuedDateBrisbane: json['issuedDateBrisbane'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'incentiveId': incentiveId,
      'offerType': offerType,
      'deliveryMethod': deliveryMethod,
      'audience': audience,
      'triggerType': triggerType,
      'timePeriod': timePeriod,
      'issuedAt': issuedAt,
      'issuedDateBrisbane': issuedDateBrisbane,
      'message': message,
    };
  }
}
