class Drawables {
  String appLogo = 'taskou_logo'.svg;
  String appLogoDark = 'taskou_logo_dark'.svg;
  String taskouLoginLogo = 'taskou_login_logo'.png;
  String otpPhone = 'otp_phone'.png;
  String menu = 'menu'.svg;
  String light = 'light'.svg;
  String dark = 'dark'.svg;
  String findServicemanUnselected = 'find_serviceman_unselected'.svg;
  String findServicemanSelected = 'find_serviceman_selected'.svg;
  String bookingsUnselected = 'bookings_unselected'.svg;
  String bookingsSelected = 'bookings_selected'.svg;
  String profileUnselected = 'profile_unselected'.svg;
  String profileSelected = 'profile_selected'.svg;
  String search = 'search'.svg;
  String phone = 'phone'.svg;
  String lock = 'lock'.svg;
  String user = 'user'.svg;
  String password = 'password'.svg;
  String email = 'email'.svg;
  String location = 'location'.svg;
  String zip = 'zip'.svg;
  String pricePerHour = 'price_per_hour'.svg;
  String otp = 'otp'.svg;
  String userAvatar = 'user_avatar'.svg;
  String back = 'back'.svg;
}

extension PngImage on String {
  String get png => 'assets/images/$this.png';
}

extension SvgImage on String {
  String get svg => 'assets/icons/$this.svg';
}

extension JpgImage on String {
  String get jpg => 'assets/images/$this.jpg';
}
