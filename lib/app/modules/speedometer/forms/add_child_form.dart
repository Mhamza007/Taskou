import 'package:reactive_forms/reactive_forms.dart';

class AddChildForm {
  static String childNameControl = 'name';
  static String relationControl = 'relation';
  static FormGroup get addChildForm => fb.group(
        {
          childNameControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          relationControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        },
      );
}
