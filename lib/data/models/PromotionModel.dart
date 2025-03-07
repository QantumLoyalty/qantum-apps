class PromotionModel {
  List<PromotionItem>? largePromotions;
  List<PromotionItem>? smallPromotions;

  PromotionModel({this.largePromotions, this.smallPromotions});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    if (json['smallPromotion'] != null) {
      smallPromotions = <PromotionItem>[];
      json['smallPromotion'].forEach((v) {
        smallPromotions!.add(PromotionItem.fromJson(v));
      });
    }
    if (json['largePromotion'] != null) {
      largePromotions = <PromotionItem>[];
      json['largePromotion'].forEach((v) {
        largePromotions!.add(PromotionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (smallPromotions != null) {
      data['smallPromotion'] = smallPromotions!.map((v) => v.toJson()).toList();
    }
    if (largePromotions != null) {
      data['largePromotion'] = largePromotions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromotionItem {
  String? sId;
  String? type;
  int? position;
  String? displayType;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updateAt;
  String? imageUrl;
  String? htmlContent;
  List<String>? audience;

  PromotionItem(
      {this.sId,
      this.type,
      this.position,
      this.displayType,
      this.startDate,
      this.endDate,
      this.imageUrl,
      this.htmlContent,
      this.audience});

  PromotionItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    position = json['position'];
    displayType = json['displayType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    imageUrl = json['imageUrl'];
    createdAt = json.containsKey('createdAt') ? json['createdAt'] : "";
    updateAt = json.containsKey('updateAt') ? json['updateAt'] : "";
    htmlContent = json['htmlContent'];
    if (json.containsKey('audience') &&
        json['audience'] != null &&
        json['audience'] is List<String>) {
      audience = json['audience'] as List<String>;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['position'] = position;
    data['displayType'] = displayType;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['imageUrl'] = imageUrl;
    data['htmlContent'] = htmlContent;

    return data;
  }
}
