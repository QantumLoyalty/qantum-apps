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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['appType'] = appType;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'VenueModel{sId: $sId, appType: $appType, name: $name,  createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
