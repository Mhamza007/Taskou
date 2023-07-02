import 'package:reactive_forms/reactive_forms.dart';

class ProfileForms {
  static String countryCodeControl = 'country_code';
  static String mobileNumberControl = 'user_mobile';
  static String lastNameControl = 'last_name';
  static String firstNameControl = 'first_name';
  static String emailControl = 'email';
  static String cityControl = 'city';
  static String provinceControl = 'province';
  static String zipCodeControl = 'zip_code';
  static String deviceTokenControl = 'device_token';

  static FormGroup get profileForm => fb.group(
        {
          countryCodeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          mobileNumberControl: FormControl<String>(
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
          deviceTokenControl: FormControl<String>(),
        },
      );
}
