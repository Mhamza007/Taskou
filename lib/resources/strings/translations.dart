import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppTranslations extends Translations {
  // Default locale
  final locale = const Locale('en');

  // fallbackLocale saves the day when the locale gets in trouble
  final fallbackLocale = const Locale('en');

  // Key
  static const String LANGUAGE = 'LANGUAGE';

  Future<void> init() async {
    final box = GetStorage();
    String? locale = box.read(LANGUAGE);
    if (locale == null) {
      Get.updateLocale(const Locale('en'));
      await box.write(LANGUAGE, 'en');
    } else {
      Get.updateLocale(Locale(locale));
    }
  }

  static void updateLocale({required String langCode}) {
    final box = GetStorage();
    Get.updateLocale(Locale(langCode));
    box.write(LANGUAGE, langCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'app_title': 'Taskou',
          'you_are_in_offline_mode':
              'You are in offline mode. Please check your connection',
          'error_signing_in': 'There was an error in signing in',
          'signed_in_successfully': 'Signed in successfully',
          'phone_number': 'Phone Number',
          'password': 'Password',
          'forgot_password': 'Forgot Password?',
          'login': 'Login',
          'child_mode': 'Child Mode',
          'dont_have_an_account': 'Don\'t have an account?',
          'signup': 'SignUp',
          'this_field_is_required': 'This field is required',
          'invalid_phone_number': 'Invalid Phone Number',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Last Name',
          'first_name': 'First Name',
          'enter_first_name': 'Enter First Name',
          'enter_password': 'Enter Password',
          'email': 'Email',
          'email_optional': 'Email (Optional)',
          'enter_email': 'Enter Email',
          'city': 'City',
          'enter_city': 'Enter City',
          'province': 'Province',
          'enter_province': 'Enter Province',
          'zip_code': 'Zip Code',
          'enter_zip_code': 'Enter Zip Code',
          'price_per_hour': 'Price Per Hour (\$)',
          'price': 'Price',
          'by_signing_up_you_agree_to_our': 'By Signing up you agree to our',
          'terms_conditions': 'Terms & Conditions',
          'and': 'and',
          'privacy_policy': 'Privacy Policy',
          'register': 'Register',
          'already_have_an_account': 'Already have an account?',
          'signin': 'SignIn',
          'send': 'Send',
          'enter_your_mobile_number': 'Enter your Mobile Number',
          'sign_up_successful': 'Sign Up Successful',
          'error_signing_up': 'Error Signing Up',
          'otp': 'OTP',
          'otp_sent_to': 'OTP sent to',
          'verify': 'Verify',
          'error_verifying_otp': 'Error verifying OTP',
          'otp_verified_successfully': 'OTP Verified Successfully',
          'user_not_verified': 'User Not Verified',
          'find_serviceman': 'Find Serviceman',
          'bookings': 'Bookings',
          'profile': 'Profile',
          'home': 'Home',
          'support': 'Support',
          'help': 'Help',
          'logout': 'Logout',
          'what_do_you_need': 'What do you need?',
          'unknown_error_occurred': 'Unknown error occurred',
          'browse_service': 'Browse Service',
          'post_work': 'Post Work',
          'light': 'Light',
          'dark': 'Dark',
          'edit': 'Edit',
          'save': 'Save',
          'resend': 'Resend',
          'current': 'Current',
          'past': 'Past',
          'upcoming': 'Upcoming',
          'available_servicemen': 'Available Servicemen',
          'certified': 'Certified',
          'jobs': 'Jobs',
          'user_auth_failed_login_again':
              'User Authentication Failed. Please login again',
          'no_data_found': 'No data found',
          'view_profile': 'View Profile',
          'book': 'Book',
          'advertising_communaction': 'Advertising & Communaction',
          'email_address': 'Email Address',
          'enter_your_message': 'Enter Your Message',
          'book_serviceman': 'Book Serviceman',
          'am': 'AM',
          'pm': 'PM',
          'jan': 'Jan',
          'feb': 'Feb',
          'mar': 'Mar',
          'apr': 'Apr',
          'may': 'May',
          'jun': 'Jun',
          'jul': 'Jul',
          'aug': 'Aug',
          'sep': 'Sep',
          'oct': 'Oct',
          'nov': 'Nov',
          'dec': 'Dec',
          'description': 'Description',
          'task_accepted': 'Task Accepted',
          'handyman_arrived': 'Handyman Arrived',
          'task_start': 'Task Start',
          'task_completed': 'Task Completed',
          'past_task': 'Past Task',
          'current_task': 'Current Task',
          'upcoming_task': 'Upcoming Task',
          'review': 'Review',
          'success': 'Success',
          'please_assign_ratings': 'Please assign ratings',
          'please_enter_your_message': 'Please enter your message',
          'ok': 'Ok',
          'enter_address': 'Enter Address',
          'search': 'Search',
          'share_code': 'Share Code',
          'delete': 'Delete',
          'tracking': 'Tracking',
          'add': 'Add',
          'child_name': 'Child Name',
          'enter_child_name': 'Enter Child Name',
          'relation': 'Relation',
          'enter_relation': 'Enter Relation',
          'child': 'Child',
          'employee': 'Employee',
          'cancel': 'Cancel',
          'error_logging_out': 'An error occurred while logging out',
          'submit': 'Submit',
          'enter_code_here': 'Enter your code here',
          'tracking_question': 'Do you want to track your Location and speed with your relative?',
          'yes': 'Yes',
          'no': 'No',
          'of': 'of',
          'stop': 'Stop',
        },
      };
}
