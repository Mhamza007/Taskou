import 'package:reactive_forms/reactive_forms.dart';

class ForgotPasswordForm {
  static String countryCodeControl = 'country_code';
  static String userMobileControl = 'user_mobile';
  static String userIdControl = 'user_id';
  static String userOtpControl = 'user_otp';
  static String passwordControl = 'password';
  static String confirmPasswordControl = 'confirm_password';

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
        },
      );

  static FormGroup get verifyForgetPasswordForm => fb.group(
        {
          userIdControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          userOtpControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        },
      );

  static FormGroup get updatePasswordForm => fb.group(
        {
          userIdControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          passwordControl: FormControl<String>(
            validators: [
              Validators.required,
              Validators.minLength(6),
            ],
          ),
          confirmPasswordControl: FormControl<String>(
            validators: [
              Validators.required,
              Validators.minLength(6),
            ],
          ),
        },
        [
          Validators.mustMatch(
            passwordControl,
            confirmPasswordControl,
          ),
        ],
      );
}
