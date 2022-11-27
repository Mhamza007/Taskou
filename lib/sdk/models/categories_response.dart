class CategoriesResponse {
  int? statusCode;
  String? message;
  List<CategoriesResponseData>? data;

  CategoriesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoriesResponseData>[];
      json['data'].forEach((v) {
        data!.add(
          CategoriesResponseData.fromJson(v),
        );
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

class CategoriesResponseData {
  String? catId;
  String? categoryName;
  String? categoryImage;
  String? price;
  String? type;

  CategoriesResponseData({
    this.catId,
    this.categoryName,
    this.categoryImage,
    this.price,
    this.type,
  });

  CategoriesResponseData.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    price = json['price'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['price'] = price;
    data['type'] = type;
    return data;
  }

  @override
  String toString() {
    return 'CategoriesResponseData(catId: $catId, categoryName: $categoryName, categoryImage: $categoryImage, price: $price, type: $type)';
  }
}
