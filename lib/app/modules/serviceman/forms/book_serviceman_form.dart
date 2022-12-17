import 'package:reactive_forms/reactive_forms.dart';

class BookServicemanForms {
  static String handymanId = 'handyman_id';
  static String handymanCity = 'handyman_city';
  static String latitude = 'user_lat';
  static String longitude = 'user_long';
  static String address = 'address';
  static String message = 'message';
  static String bookingType = 'booking_type';
  static String scheduleDate = 'schedule_date';
  static String scheduleTime = 'schedule_time';

  static FormGroup get bookNowForm => fb.group(
        {
          handymanId: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          handymanCity: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          latitude: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          longitude: FormControl<String>(
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
          bookingType: FormControl<String>(
            validators: [
              Validators.required,
            ],
            value: '2',
          ),
        },
      );

  static FormGroup get bookLaterForm => fb.group(
        {
          handymanId: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          handymanCity: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          latitude: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          longitude: FormControl<String>(
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
          bookingType: FormControl<String>(
            validators: [
              Validators.required,
            ],
            value: '2',
          ),
          scheduleDate: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          scheduleTime: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        },
      );
}
