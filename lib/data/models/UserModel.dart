class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? gender;
  String? phoneNumber;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.dob,
      this.gender,
      this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    dob = json['dob'] ?? "";
    gender = json['gender'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id ?? "";
    data['firstName'] = firstName ?? "";
    data['lastName'] = lastName ?? "";
    data['email'] = email ?? "";
    data['dob'] = dob ?? "";
    data['gender'] = gender ?? "";
    data['phoneNumber'] = phoneNumber ?? "";

    return data;
  }
}
