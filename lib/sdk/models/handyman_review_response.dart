class HandymanReviewResponse {
  int? statusCode;
  List<HandymanReviewData>? data;
  String? message;

  HandymanReviewResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  HandymanReviewResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <HandymanReviewData>[];
      json['data'].forEach((v) {
        data!.add(HandymanReviewData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class HandymanReviewData {
  String? ratingId;
  String? handymanId;
  String? rating;
  String? message;
  String? userId;
  String? comentedBy;

  HandymanReviewData({
    this.ratingId,
    this.handymanId,
    this.rating,
    this.message,
    this.userId,
    this.comentedBy,
  });

  HandymanReviewData.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    handymanId = json['handyman_id'];
    rating = json['rating'];
    message = json['message'];
    userId = json['user_id'];
    comentedBy = json['comented_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating_id'] = ratingId;
    data['handyman_id'] = handymanId;
    data['rating'] = rating;
    data['message'] = message;
    data['user_id'] = userId;
    data['comented_by'] = comentedBy;
    return data;
  }
}
