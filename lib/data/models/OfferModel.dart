class OfferModel {
  String? header;
  String? description;
  String? voucherType;
  List<String>? ratingLevel;
  Expiry? expiry;
  List<String>? validDays;
  ValidTime? validTime;
  int? triggerValue;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;
  String? qrURL;

  OfferModel(
      {this.header,
      this.description,
      this.voucherType,
      this.ratingLevel,
      this.expiry,
      this.validDays,
      this.validTime,
      this.triggerValue,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,this.id,this.qrURL});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    header = json['header'];
    description = json['description'];
    voucherType = json['voucherType'];
    ratingLevel = json['ratingLevel'].cast<String>();
    expiry = json['expiry'] != null ? Expiry.fromJson(json['expiry']) : null;
    validDays = json['validDays'].cast<String>();
    validTime = json['validTime'] != null
        ? ValidTime.fromJson(json['validTime'])
        : null;
    triggerValue = json['triggerValue'];
    image = json['image'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    qrURL=json['qr_url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    data['header'] = header;
    data['description'] = description;
    data['voucherType'] = voucherType;
    data['ratingLevel'] = ratingLevel;
    if (expiry != null) {
      data['expiry'] = expiry!.toJson();
    }
    data['validDays'] = validDays;
    if (validTime != null) {
      data['validTime'] = validTime!.toJson();
    }
    data['triggerValue'] = triggerValue;
    data['image'] = image;
    data['status'] = status;
    if (createdAt != null) {
      data['createdAt'] = createdAt!;
    }
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt!;
    }
    data['__v'] = iV;
    return data;
  }

  @override
  String toString() {
    return 'OfferModel{header: $header, description: $description, voucherType: $voucherType, ratingLevel: $ratingLevel, expiry: $expiry, validDays: $validDays, validTime: $validTime, triggerValue: $triggerValue, image: $image, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV, id: $id, qrURL: $qrURL}';
  }
}

class Expiry {
  String? type;
  ValidFrom? validFrom;
  ValidFrom? validTo;

  Expiry({this.type, this.validFrom, this.validTo});

  Expiry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    validFrom = json['validFrom'] != null
        ? ValidFrom.fromJson(json['validFrom'])
        : null;
    validTo =
        json['validTo'] != null ? ValidFrom.fromJson(json['validTo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (validFrom != null) {
      data['validFrom'] = validFrom!.toJson();
    }
    if (validTo != null) {
      data['validTo'] = validTo!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Expiry{type: $type, validFrom: $validFrom, validTo: $validTo}';
  }
}

class ValidFrom {
  String? date;

  ValidFrom({this.date});

  ValidFrom.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$date'] = date;
    return data;
  }

  @override
  String toString() {
    return 'ValidFrom{date: $date}';
  }
}

class ValidTime {
  String? startTime;
  String? endTime;

  ValidTime({this.startTime, this.endTime});

  ValidTime.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }

  @override
  String toString() {
    return 'ValidTime{startTime: $startTime, endTime: $endTime}';
  }
}
