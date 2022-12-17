import 'package:flutter/material.dart';

import '../app.dart';

enum _PageTransitionType {
  fade,
  rightToLeft,
  bottomToTop,
  rightToLeftFaded,
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.initial:
        return _PageTransition(
          child: const SplashScreen(),
          type: _PageTransitionType.fade,
        );
      case Routes.signIn:
        return _PageTransition(
          child: const SignInScreen(),
        );
      case Routes.signUp:
        return _PageTransition(
          child: const SignUpScreen(),
        );
      case Routes.forgotPassword:
        return _PageTransition(
          child: const ForgotPasswordScreen(),
        );
      case Routes.otp:
        args as Map?;
        return _PageTransition(
          child: OtpScreen(
            data: args,
          ),
        );
      case Routes.dashboard:
        return _PageTransition(
          child: const DashboardScreen(),
        );
      case Routes.subCategory:
        args as Map;
        return _PageTransition(
          child: SubCategoryScreen(
            title: args['title'],
            subCategoryResponse: args['response'],
          ),
        );
      case Routes.browseService:
        args as Map;
        return _PageTransition(
          child: BrowseServiceScreen(
            data: args,
          ),
        );
      case Routes.postWork:
        args as Map<String, dynamic>;
        return _PageTransition(
          child: PostWorkScreen(
            data: args,
          ),
        );
      case Routes.bookingStatus:
        args as Map;
        return _PageTransition(
          child: BookingStatusScreen(
            data: args,
          ),
        );
      case Routes.review:
        args as Map;
        return _PageTransition(
          child: ReviewScreen(
            data: args,
          ),
        );
      case Routes.locationMap:
        return _PageTransition(
          child: const LocationMapScreen(),
        );
      case Routes.placesSearch:
        return _PageTransition(
          child: const PlacesSearchScreen(),
        );
      case Routes.tracking:
        return _PageTransition(
          child: const TrackingScreen(),
        );
      case Routes.addChild:
        return _PageTransition(
          child: const AddChildScreen(),
        );
      case Routes.speedometerMap:
        args as Map<String, dynamic>;
        return _PageTransition(
          child: SpeedometerMapScreen(
            data: args,
          ),
        );
      case Routes.childMode:
        return _PageTransition(
          child: const ChildModeScreen(),
        );
      // case Routes.sync_home:
      //   return _PageTransition(
      //     child: SyncScreen(),
      //     type: _PageTransitionType.bottomToTop,
      //   );
      // case Routes.clas:
      //   args as Map?;
      //   return _PageTransition(
      //     child: ClassesScreen(
      //       userId: args?['user_id'],
      //       semis: args?['semis'],
      //       gender: args?['gender'],
      //     ),
      //   );
      // case Routes.class_attendance:
      //   args as Map;
      //   return _PageTransition(
      //     child: ClassAttendanceScreen(
      //       classId: args['class_id'] as String,
      //       className: args['class_name'] as String,
      //     ),
      //   );
      // case Routes.qr_attendance:
      //   return _PageTransition(
      //     child: QrAttendanceScreen(),
      //   );
      // case Routes.qr_attendance_home:
      //   return _PageTransition(
      //     child: QrAttendanceScreen(),
      //     type: _PageTransitionType.bottomToTop,
      //   );
      // case Routes.data_download:
      //   return _PageTransition(
      //     child: DataDownloadScreen(),
      //   );
      // case Routes.staff_absent:
      //   return _PageTransition(
      //     child: StaffAbsentScreen(),
      //   );
      // case Routes.mark_staff:
      //   args as Map;
      //   return _PageTransition(
      //     child: MarkedStaffScreen(
      //       staffId: args['staff_id'] as String,
      //     ),
      //   );
      // case Routes.online_student:
      //   return _PageTransition(
      //     child: OnlineStudentScreen(),
      //   );
      // case Routes.guardian_cnic:
      //   return _PageTransition(
      //     child: GuardianCnicScreen(),
      //   );
      // case Routes.student_enrollment:
      //   args as Map?;
      //   return _PageTransition(
      //     child: StudentEnrollmentScreen(
      //       guardian: args?['guardian'],
      //       cnic: args?['cnic'],
      //     ),
      //   );
      // case Routes.listingImages:
      //   args as List;
      //   return _PageTransition(
      //     child: ListingImagesScreen(
      //       initialIndex: args[0] as int,
      //       listingImages: args[1] as List<ListingImages>,
      //       listingImagesThumb: args[2] as List<ListingImages>,
      //     ),
      //   );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class _PageTransition<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Curve curve;
  final Duration duration;
  final Duration reverseDuration;
  final _PageTransitionType type;

  _PageTransition({
    required this.child,
    this.type = _PageTransitionType.rightToLeftFaded,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return child;
          },
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          settings: settings,
          maintainState: true,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            switch (type) {
              case _PageTransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case _PageTransitionType.rightToLeft:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              case _PageTransitionType.rightToLeftFaded:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                );
              case _PageTransitionType.bottomToTop:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              default:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
}
