import 'package:reactive_forms/reactive_forms.dart';

class ChangePasswordForm {
  static String oldPasswordControl = 'old_password';
  static String newPasswordControl = 'password';
  static String confirmPasswordControl = 'confirm_password';

  static FormGroup get changePasswordForm => fb.group(
        {
          oldPasswordControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          newPasswordControl: FormControl<String>(
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
            newPasswordControl,
            confirmPasswordControl,
          ),
        ],
      );
}
