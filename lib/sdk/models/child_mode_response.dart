class ChildModeResponse {
  int? statusCode;
  String? message;
  ChildModeData? data;

  ChildModeResponse({this.statusCode, this.message, this.data});

  ChildModeResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ChildModeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChildModeData {
  String? id;
  String? name;
  String? relation;
  String? relatedId;
  String? phone;
  String? email;
  String? code;
  String? createdAt;
  String? updatedAt;
  String? relatedName;

  ChildModeData({
    this.id,
    this.name,
    this.relation,
    this.relatedId,
    this.phone,
    this.email,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.relatedName,
  });

  ChildModeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    relation = json['relation'];
    relatedId = json['related_id'];
    phone = json['phone'];
    email = json['email'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    relatedName = json['related_name'];
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
    data['related_name'] = relatedName;
    return data;
  }
}
