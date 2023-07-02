import 'dart:convert';

class Contact {
  String? contactId;
  String? fcmToken;
  int? dateTime;

  Contact({
    required this.contactId,
    required this.fcmToken,
    required this.dateTime,
  });

  Contact copyWith({
    String? contactId,
    int? dateTime,
  }) {
    return Contact(
      contactId: contactId ?? this.contactId,
      fcmToken: fcmToken ?? this.fcmToken,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (contactId != null) {
      result.addAll({'contact_id': contactId});
    }
    if (fcmToken != null) {
      result.addAll({'fcmToken': fcmToken});
    }
    if (dateTime != null) {
      result.addAll({'date_time': dateTime});
    }

    return result;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      contactId: map['contact_id'],
      fcmToken: map['fcmToken'],
      dateTime: map['date_time']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));

  @override
  String toString() => 'Contact(contactId: $contactId, dateTime: $dateTime)';
}
