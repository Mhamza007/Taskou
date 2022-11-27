T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

String asString<T>(dynamic value) {
  if (value != null && value is List && value.isNotEmpty) {
    return value.first;
  }
  if (value != null && value is String) {
    return value;
  }
  return '';
}
