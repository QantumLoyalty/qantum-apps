class OfferModel {
  String? header;
  String? description;
  String? voucherType;
  List<String>? ratingLevel;
  Expiry? expiry;
  List<String>? validDaysOfWeek;
  ValidTime? validTime;
  String? triggerValue;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? qrURL;
  bool? active;
  String? expiryDate;
  String? appears;

  OfferModel(
      {this.header,
      this.description,
      this.voucherType,
      this.ratingLevel,
      this.expiry,
      this.validDaysOfWeek,
      this.validTime,
      this.triggerValue,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.qrURL,
      this.expiryDate,
      this.appears});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    header = json['header'];
    description = json['description'];
    voucherType = json['voucherType'];
    ratingLevel = json['ratingLevel'].cast<String>();
    expiry = json['expiry'] != null ? Expiry.fromJson(json['expiry']) : null;
    validDaysOfWeek = json['validDaysOfWeek'].cast<String>();
    validTime = json['validTime'] != null
        ? ValidTime.fromJson(json['validTime'])
        : null;
    triggerValue = json['triggerValue'];
    image = json['image'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    qrURL = json['qr_url'] ?? "";
    active = json['active'] ?? false;
    expiryDate = json['expiryDate'] ?? "";

    if (json.containsKey('appears')) {
      appears = json['appears'];
    }
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
    data['validDaysOfWeek'] = validDaysOfWeek;
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
    if (active != null) {
      data['active'] = active!;
    }
    if (expiryDate != null) {
      data['expiryDate'] = expiryDate!;
    }
    if (appears != null) {
      data['appears'] = appears!;
    }

    return data;
  }

  @override
  String toString() {
    return 'OfferModel{header: $header, description: $description, voucherType: $voucherType, ratingLevel: $ratingLevel, expiry: $expiry, validDays: $validDaysOfWeek, validTime: $validTime, triggerValue: $triggerValue, image: $image, status: $status, createdAt: $createdAt, updatedAt: $updatedAt,id: $id, qrURL: $qrURL, appears: $appears}';
  }
}

class Expiry {
  String? type;
  int? expiresInDays;

  Expiry({this.type, this.expiresInDays});

  Expiry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    expiresInDays = json['expiresInDays'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (expiresInDays != null) {
      data['expiresInDays'] = expiresInDays!;
    }

    return data;
  }

  @override
  String toString() {
    return 'Expiry{type: $type, expiresInDays: $expiresInDays}';
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
  String? type;
  String? startTime;
  String? endTime;

  ValidTime({this.type, this.startTime, this.endTime});

  ValidTime.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? "";
    startTime = json['startTime'] ?? "";
    endTime = json['endTime'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type ?? "";
    data['startTime'] = startTime ?? "";
    data['endTime'] = endTime ?? "";
    return data;
  }

  @override
  String toString() {
    return 'ValidTime{startTime: $startTime, endTime: $endTime}';
  }
}
