import 'package:reactive_forms/reactive_forms.dart';

class ChildModeForms {
  static String codeControl = 'code';

  static FormGroup get codeForm => fb.group(
        {
          codeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        },
      );
}
