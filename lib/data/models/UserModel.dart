class UserModel {
  String? id;
  String? bluizeUniqueUserId;
  String? firstName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? gender;
  String? mobile;
  String? postCode;
  int? bluizeId;
  String? cardNumber;
  String? address;
  String? suburb;
  String? state;
  String? dateJoined;
  num? pointsBalance;
  num? pointsValue;
  num? statusPoints;
  String? statusTier;
  num? requiredStatusPointsForNextTier;
  String? nextStatusTier;
  String? membershipType;
  String? membershipCategory;
  num? accountAvailableBalance;
  String? accountType;
  bool? acceptsEmail;
  bool? acceptsSMS;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.mobile,
      this.postCode,
      this.bluizeId,
      this.cardNumber,
      this.address,
      this.suburb,
      this.state,
      this.dateJoined,
      this.pointsBalance,
      this.pointsValue,
      this.statusPoints,
      this.statusTier,
      this.requiredStatusPointsForNextTier,
      this.nextStatusTier,
      this.membershipType,
      this.membershipCategory,
      this.accountAvailableBalance,
      this.accountType,
      this.acceptsEmail,
      this.acceptsSMS,
      this.bluizeUniqueUserId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    bluizeUniqueUserId = json.containsKey("Id") ? json['Id'] : "";
    firstName = json['GivenNames'] ?? "";
    lastName = json['Surname'] ?? "";
    email = json['Email'] ?? "";
    dateOfBirth = json['DateOfBirth'] ?? "";
    gender = json['Gender'] ?? "";
    mobile = json['Mobile'] ?? "";
    postCode = json['PostCode'] ?? "";
    bluizeId = json.containsKey("BluizeId") ? json["BluizeId"] : 0;
    cardNumber = json.containsKey("CardNumber") ? json["CardNumber"] : "";
    address = json.containsKey("Address") ? json["Address"] : "";
    suburb = json.containsKey("Suburb") ? json["Suburb"] : "";
    state = json.containsKey("State") ? json["State"] ?? "" : "";
    dateJoined = json.containsKey("DateJoined") ? json["DateJoined"] : "";
    pointsValue =
        json.containsKey("PointsBalance") ? json["PointsBalance"] : 0.0;
    pointsBalance = json.containsKey("PointsValue") ? json["PointsValue"] : 0.0;
    statusPoints =
        json.containsKey("StatusPoints") ? json["StatusPoints"] : 0.0;
    statusTier = json.containsKey("StatusTier") ? json["StatusTier"] ?? "" : "";
    requiredStatusPointsForNextTier =
        json.containsKey("RequiredStatusPointsForNextTier")
            ? json["RequiredStatusPointsForNextTier"]
            : 0.0;
    nextStatusTier =
        json.containsKey("NextStatusTier") ? json["NextStatusTier"] : "";
    membershipType =
        json.containsKey("MembershipType") ? json["MembershipType"] : "";
    membershipCategory = json.containsKey("MembershipCategory")
        ? json["MembershipCategory"]
        : "";
    accountAvailableBalance = json.containsKey("AccountAvailableBalance")
        ? json["AccountAvailableBalance"]
        : 0.0;
    accountType = json.containsKey("AccountType") ? json["AccountType"] : "";
    acceptsEmail =
        json.containsKey("AcceptsEmail") ? json["AcceptsEmail"] : false;
    acceptsSMS = json.containsKey("AcceptsSMS") ? json["AcceptsSMS"] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id ?? "";
    data['Id'] = bluizeUniqueUserId ?? "";
    data['GivenNames'] = firstName ?? "";
    data['Surname'] = lastName ?? "";
    data['Email'] = email ?? "";
    data['DateOfBirth'] = dateOfBirth ?? "";
    data['Gender'] = gender ?? "";
    data['Mobile'] = mobile ?? "";
    data['PostCode'] = postCode ?? "";
    data['BluizeId'] = bluizeId ?? "";
    data['CardNumber'] = cardNumber ?? "";
    data['Address'] = address ?? "";
    data['Suburb'] = suburb ?? "";
    data['State'] = state ?? "";
    data['DateJoined'] = dateJoined ?? "";
    data['PointsBalance'] = pointsBalance ?? 0.0;
    data['PointsValue'] = pointsValue ?? 0.0;
    data['StatusPoints'] = statusPoints ?? 0.0;
    data['StatusTier'] = statusTier ?? "";
    data['RequiredStatusPointsForNextTier'] =
        requiredStatusPointsForNextTier ?? 0.0;
    data['NextStatusTier'] = nextStatusTier ?? "";
    data['MembershipType'] = membershipType ?? "";
    data['MembershipCategory'] = membershipCategory ?? "";
    data['AccountAvailableBalance'] = accountAvailableBalance ?? 0.0;
    data['AccountType'] = accountType ?? "";
    data['AcceptsEmail'] = acceptsEmail ?? false;
    data['AcceptsSMS'] = acceptsSMS ?? false;
    return data;
  }

  copyWith({
    String? id,
    String? bluizeUniqueUserId,
    String? firstName,
    String? lastName,
    String? email,
    String? dateOfBirth,
    String? gender,
    String? mobile,
    String? postCode,
    int? bluizeId,
    String? cardNumber,
    String? address,
    String? suburb,
    String? state,
    String? dateJoined,
    num? pointsBalance,
    num? pointsValue,
    num? statusPoints,
    String? statusTier,
    num? requiredStatusPointsForNextTier,
    String? nextStatusTier,
    String? membershipType,
    String? membershipCategory,
    num? accountAvailableBalance,
    String? accountType,
    bool? acceptsEmail,
    bool? acceptsSMS,
  }) {
    return UserModel(
      id: id ?? this.id,
      bluizeUniqueUserId: bluizeUniqueUserId ?? this.bluizeUniqueUserId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      postCode: postCode ?? this.postCode,
      bluizeId: bluizeId ?? this.bluizeId,
      cardNumber: cardNumber ?? this.cardNumber,
      address: address ?? this.address,
      suburb: suburb ?? this.suburb,
      state: state ?? this.state,
      dateJoined: dateJoined ?? this.dateJoined,
      pointsBalance: pointsBalance ?? this.pointsBalance,
      pointsValue: pointsValue ?? this.pointsValue,
      statusPoints: statusPoints ?? this.statusPoints,
      statusTier: statusTier ?? this.statusTier,
      requiredStatusPointsForNextTier: requiredStatusPointsForNextTier ??
          this.requiredStatusPointsForNextTier,
      nextStatusTier: nextStatusTier ?? this.nextStatusTier,
      membershipType: membershipType ?? this.membershipType,
      membershipCategory: membershipCategory ?? this.membershipCategory,
      accountAvailableBalance:
          accountAvailableBalance ?? this.accountAvailableBalance,
      accountType: accountType ?? this.accountType,
      acceptsEmail: acceptsEmail ?? this.acceptsEmail,
      acceptsSMS: acceptsSMS ?? this.acceptsSMS,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id,Id: $bluizeUniqueUserId, firstName: $firstName, lastName: $lastName, email: $email, dateOfBirth: $dateOfBirth, gender: $gender, mobile: $mobile, postCode: $postCode, bluizeId: $bluizeId, cardNumber: $cardNumber, address: $address, suburb: $suburb, state: $state, dateJoined: $dateJoined, pointsBalance: $pointsBalance, pointsValue: $pointsValue, statusPoints: $statusPoints, statusTier: $statusTier, requiredStatusPointsForNextTier: $requiredStatusPointsForNextTier, nextStatusTier: $nextStatusTier, membershipType: $membershipType, membershipCategory: $membershipCategory, accountAvailableBalance: $accountAvailableBalance, accountType: $accountType, acceptsEmail: $acceptsEmail, acceptsSMS: $acceptsSMS}';
  }
}
