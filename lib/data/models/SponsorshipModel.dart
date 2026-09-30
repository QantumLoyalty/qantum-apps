class SponsorshipModel {
  String? sId;
  String? company;
  String? firstName;
  int? memberCount;
  String? lastName;
  String? phone;
  String? email;
  String? address;
  String? pin;
  String? sponsorshipCode;

  @override
  String toString() {
    return 'SponsorshipModel{sId: $sId, company: $company, firstName: $firstName, memberCount: $memberCount, lastName: $lastName, phone: $phone, email: $email, address: $address, pin: $pin, sponsorshipCode: $sponsorshipCode}';
  }

  SponsorshipModel(
      {this.sId,
        this.company,
        this.firstName,
        this.memberCount,
        this.lastName,
        this.phone,
        this.email,
        this.address,
        this.pin,
        this.sponsorshipCode});

  SponsorshipModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    company = json['company'];
    firstName = json['firstName'];
    memberCount = json['memberCount'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    pin = json['pin'];
    sponsorshipCode = json['sponsorshipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['company'] = company;
    data['firstName'] = firstName;
    data['memberCount'] = memberCount;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['pin'] = pin;
    data['sponsorshipCode'] = sponsorshipCode;
    return data;
  }
}