class TrackingResponse {
  int? statusCode;
  String? message;
  List<TrackingResponseData>? data;

  TrackingResponse({this.statusCode, this.message, this.data});

  TrackingResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrackingResponseData>[];
      json['data'].forEach((v) {
        data!.add(TrackingResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrackingResponseData {
  String? id;
  String? name;
  String? relation;
  String? relatedId;
  dynamic phone;
  dynamic email;
  String? code;
  String? createdAt;
  String? updatedAt;

  TrackingResponseData(
      {this.id,
      this.name,
      this.relation,
      this.relatedId,
      this.phone,
      this.email,
      this.code,
      this.createdAt,
      this.updatedAt});

  TrackingResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    relation = json['relation'];
    relatedId = json['related_id'];
    phone = json['phone'];
    email = json['email'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['relation'] = relation;
    data['related_id'] = relatedId;
    data['phone'] = phone;
    data['email'] = email;
    data['code'] = code;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
