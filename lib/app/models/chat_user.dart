import 'dart:convert';

class ChatUser {
  ChatUser({
    required this.firebaseUserId,
    this.serverUserId,
    this.authType,
    this.userType,
    this.workType,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.businessName,
  });

  String firebaseUserId;
  String? serverUserId;
  String? authType;
  String? userType;
  String? workType;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? businessName;

  ChatUser copyWith({
    String? firebaseUserId,
    String? serverUserId,
    String? authType,
    String? userType,
    String? workType,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? businessName,
  }) {
    return ChatUser(
      firebaseUserId: firebaseUserId ?? this.firebaseUserId,
      serverUserId: serverUserId ?? this.serverUserId,
      authType: authType ?? this.authType,
      userType: userType ?? this.userType,
      workType: workType ?? this.workType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      businessName: businessName ?? this.businessName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firebase_user_id': firebaseUserId});

    if (serverUserId != null) {
      result.addAll({'server_user_id': serverUserId});
    }

    if (authType != null) {
      result.addAll({'auth_type': authType});
    }

    if (userType != null) {
      result.addAll({'user_type': userType});
    }

    if (workType != null) {
      result.addAll({'work_type': workType});
    }

    if (phoneNumber != null) {
      result.addAll({'phone_number': phoneNumber});
    }

    if (firstName != null) {
      result.addAll({'first_name': firstName});
    }

    if (lastName != null) {
      result.addAll({'last_name': lastName});
    }

    if (businessName != null) {
      result.addAll({'business_name': businessName});
    }

    return result;
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      firebaseUserId: map['firebase_user_id'] ?? '',
      serverUserId: map['server_user_id'],
      authType: map['auth_type'],
      userType: map['user_type'],
      workType: map['work_type'],
      phoneNumber: map['phone_number'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      businessName: map['business_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUser.fromJson(String source) =>
      ChatUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatUser(firebaseUserId: $firebaseUserId, serverUserId: $serverUserId, authType: $authType, userType: $userType, workType: $workType, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, businessName: $businessName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatUser &&
        other.firebaseUserId == firebaseUserId &&
        other.serverUserId == serverUserId &&
        other.authType == authType &&
        other.userType == userType &&
        other.workType == workType &&
        other.phoneNumber == phoneNumber &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.businessName == businessName;
  }

  @override
  int get hashCode {
    return firebaseUserId.hashCode ^
        serverUserId.hashCode ^
        authType.hashCode ^
        userType.hashCode ^
        workType.hashCode ^
        phoneNumber.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        businessName.hashCode;
  }
}
