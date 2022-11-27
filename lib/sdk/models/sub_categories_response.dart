class SubCategoriesResponse {
  int? statusCode;
  String? message;
  List<SubCategoriesData>? data;

  SubCategoriesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  SubCategoriesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubCategoriesData>[];
      json['data'].forEach((v) {
        data!.add(SubCategoriesData.fromJson(v));
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

class SubCategoriesData {
  String? subCatId;
  String? categoryId;
  String? subCategory;
  String? subCategoryImage;
  String? subCategoryPrice;

  SubCategoriesData({
    this.subCatId,
    this.categoryId,
    this.subCategory,
    this.subCategoryImage,
    this.subCategoryPrice,
  });

  SubCategoriesData.fromJson(Map<String, dynamic> json) {
    subCatId = json['sub_cat_id'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    subCategoryImage = json['sub_category_image'];
    subCategoryPrice = json['sub_category_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_cat_id'] = subCatId;
    data['category_id'] = categoryId;
    data['sub_category'] = subCategory;
    data['sub_category_image'] = subCategoryImage;
    data['sub_category_price'] = subCategoryPrice;
    return data;
  }
}
