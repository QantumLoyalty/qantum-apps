class BenefitsModel {
  String? id;
  String? htmlcontent;
  List<String>? type;

  BenefitsModel({this.id, this.htmlcontent, this.type});

  BenefitsModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? "";
    htmlcontent = json["htmlcontent"] ?? "";
    if (json.containsKey('type') &&
        json['type'] != null &&
        json['type'] is List<String>) {
      type = json['type'] as List<String>;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id ?? "";
    data["htmlcontent"] = htmlcontent ?? "";
    data["type"] = type ?? [];

    return data;
  }
}
