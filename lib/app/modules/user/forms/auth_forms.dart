import 'package:reactive_forms/reactive_forms.dart';

class AuthForms {
  static String userMobileControl = 'user_mobile';
  static String contactPhoneControl = 'contact_phone';
  static String passwordControl = 'user_password';
  static String lastNameControl = 'last_name';
  static String firstNameControl = 'first_name';
  static String emailControl = 'email';
  static String cityControl = 'city';
  static String provinceControl = 'province';
  static String zipCodeControl = 'zip_code';
  static String pricePerHourControl = 'price_per_hour';
  static String countryCodeControl = 'country_code';
  static String deviceTokenControl = 'device_token';

  static FormGroup get signInForm => fb.group(
        {
          countryCodeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          userMobileControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          passwordControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          deviceTokenControl: FormControl<String>(),
        },
      );

  static FormGroup get signUpForm => fb.group(
        {
          countryCodeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          contactPhoneControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          lastNameControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          firstNameControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          passwordControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          emailControl: FormControl<String>(
            validators: [
              Validators.email,
            ],
          ),
          cityControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          provinceControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          zipCodeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          pricePerHourControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          deviceTokenControl: FormControl<String>(),
        },
      );

  static FormGroup get forgotPasswordForm => fb.group(
        {
          countryCodeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          userMobileControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          deviceTokenControl: FormControl<String>(),
        },
      );
}
