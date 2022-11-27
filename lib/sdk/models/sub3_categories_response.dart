class Sub3CategoriesResponse {
  int? statusCode;
  String? message;
  List<Sub3CategoriesData>? data;

  Sub3CategoriesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  Sub3CategoriesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Sub3CategoriesData>[];
      json['data'].forEach((v) {
        data!.add(Sub3CategoriesData.fromJson(v));
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

class Sub3CategoriesData {
  String? id;
  String? subSubId;
  String? subId;
  String? catId;
  String? subSubSubCatName;
  String? subSubSubCatImage;
  String? subSubSubCatPrice;

  Sub3CategoriesData({
    this.id,
    this.subSubId,
    this.subId,
    this.catId,
    this.subSubSubCatName,
    this.subSubSubCatImage,
    this.subSubSubCatPrice,
  });

  Sub3CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subSubId = json['sub_sub_id'];
    subId = json['sub_id'];
    catId = json['cat_id'];
    subSubSubCatName = json['sub_sub_sub_cat_name'];
    subSubSubCatImage = json['sub_sub_sub_cat_image'];
    subSubSubCatPrice = json['sub_sub_sub_cat_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_sub_id'] = subSubId;
    data['sub_id'] = subId;
    data['cat_id'] = catId;
    data['sub_sub_sub_cat_name'] = subSubSubCatName;
    data['sub_sub_sub_cat_image'] = subSubSubCatImage;
    data['sub_sub_sub_cat_price'] = subSubSubCatPrice;
    return data;
  }
}
