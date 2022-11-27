class BrowseServiceResponse {
  int? statusCode;
  String? message;
  List<BrowseServiceData>? browseServiceData;

  BrowseServiceResponse({
    this.statusCode,
    this.message,
    this.browseServiceData,
  });

  BrowseServiceResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      browseServiceData = <BrowseServiceData>[];
      json['data'].forEach((v) {
        browseServiceData!.add(BrowseServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (browseServiceData != null) {
      data['data'] = browseServiceData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrowseServiceData {
  String? handymanId;
  String? catId;
  String? sub1Id;
  String? sub2Id;
  String? sub3Id;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? profileImg;
  String? isUpdated;
  String? userStatus;
  String? isAvailable;
  String? idFront;
  String? idBack;
  String? certFront;
  String? certBack;
  String? price;
  String? description;
  String? province;
  String? zipCode;
  String? countryCode;
  String? userMobile;
  double? ratings;
  int? getJobs;
  List<WorkPhotos>? workPhotos;

  BrowseServiceData({
    this.handymanId,
    this.catId,
    this.sub1Id,
    this.sub2Id,
    this.sub3Id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.profileImg,
    this.isUpdated,
    this.userStatus,
    this.isAvailable,
    this.idFront,
    this.idBack,
    this.certFront,
    this.certBack,
    this.price,
    this.description,
    this.province,
    this.zipCode,
    this.countryCode,
    this.userMobile,
    this.ratings,
    this.getJobs,
    this.workPhotos,
  });

  BrowseServiceData.fromJson(Map<String, dynamic> json) {
    handymanId = json['handyman_id'];
    catId = json['cat_id'];
    sub1Id = json['sub1_id'];
    sub2Id = json['sub2_id'];
    sub3Id = json['sub3_id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    profileImg = json['profile_img'];
    isUpdated = json['is_updated'];
    userStatus = json['user_status'];
    isAvailable = json['is_available'];
    idFront = json['id_front'];
    idBack = json['id_back'];
    certFront = json['cert_front'];
    certBack = json['cert_back'];
    price = json['price'];
    description = json['description'];
    province = json['province'];
    zipCode = json['zip_code'];
    countryCode = json['country_code'];
    userMobile = json['user_mobile'];
    ratings = double.parse((json['ratings'] ?? 0).toString());
    getJobs = json['get_jobs'];
    if (json['work_photos'] != null) {
      workPhotos = <WorkPhotos>[];
      json['work_photos'].forEach((v) {
        workPhotos!.add(WorkPhotos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['handyman_id'] = handymanId;
    data['cat_id'] = catId;
    data['sub1_id'] = sub1Id;
    data['sub2_id'] = sub2Id;
    data['sub3_id'] = sub3Id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['city'] = city;
    data['profile_img'] = profileImg;
    data['is_updated'] = isUpdated;
    data['user_status'] = userStatus;
    data['is_available'] = isAvailable;
    data['id_front'] = idFront;
    data['id_back'] = idBack;
    data['cert_front'] = certFront;
    data['cert_back'] = certBack;
    data['price'] = price;
    data['description'] = description;
    data['province'] = province;
    data['zip_code'] = zipCode;
    data['country_code'] = countryCode;
    data['user_mobile'] = userMobile;
    data['ratings'] = ratings;
    data['get_jobs'] = getJobs;
    if (workPhotos != null) {
      data['work_photos'] = workPhotos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkPhotos {
  String? id;
  String? handymanId;
  String? image;
  String? createdAt;
  String? updatedAt;

  WorkPhotos({
    this.id,
    this.handymanId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  WorkPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handymanId = json['handyman_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handyman_id'] = handymanId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
