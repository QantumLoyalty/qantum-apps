class VenueModel {
  String? sId;
  String? appType;
  String? name;
  String? createdAt;
  String? updatedAt;

  VenueModel(
      {this.sId,
        this.appType,
        this.name,
        this.createdAt,
        this.updatedAt});

  VenueModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appType = json['appType'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['appType'] = this.appType;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'VenueModel{sId: $sId, appType: $appType, name: $name,  createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
