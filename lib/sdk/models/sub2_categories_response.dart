class Sub2CategoriesResponse {
  int? statusCode;
  String? message;
  List<Sub2CategoriesData>? data;

  Sub2CategoriesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  Sub2CategoriesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Sub2CategoriesData>[];
      json['data'].forEach((v) {
        data!.add(Sub2CategoriesData.fromJson(v));
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

class Sub2CategoriesData {
  String? id;
  String? subcatId;
  String? catId;
  String? subSubCatName;
  String? subSubCatImage;
  String? subSubCatPrice;

  Sub2CategoriesData({
    this.id,
    this.subcatId,
    this.catId,
    this.subSubCatName,
    this.subSubCatImage,
    this.subSubCatPrice,
  });

  Sub2CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcatId = json['subcat_id'];
    catId = json['cat_id'];
    subSubCatName = json['sub_sub_cat_name'];
    subSubCatImage = json['sub_sub_cat_image'];
    subSubCatPrice = json['sub_sub_cat_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subcat_id'] = subcatId;
    data['cat_id'] = catId;
    data['sub_sub_cat_name'] = subSubCatName;
    data['sub_sub_cat_image'] = subSubCatImage;
    data['sub_sub_cat_price'] = subSubCatPrice;
    return data;
  }
}
