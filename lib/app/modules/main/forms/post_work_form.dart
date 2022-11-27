import 'package:reactive_forms/reactive_forms.dart';

class PostWorkForms {
  static String catId = 'cat_id';
  static String sub1Id = 'sub1_id';
  static String sub2Id = 'sub2_id';
  static String sub3Id = 'sub3_id';
  static String bookingType = 'booking_type';
  static String address = 'address';
  static String message = 'message';
  static String userLat = 'user_lat';
  static String userLong = 'user_long';

  static FormGroup get postWorkForm => fb.group(
        {
          catId: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          sub1Id: FormControl<String>(
            validators: [],
          ),
          sub2Id: FormControl<String>(
            validators: [],
          ),
          sub3Id: FormControl<String>(
            validators: [],
          ),
          bookingType: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          address: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          message: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          userLat: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          userLong: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        },
      );
}
