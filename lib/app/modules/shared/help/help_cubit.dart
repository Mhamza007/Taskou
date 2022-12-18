import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';

part 'help_state.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit(
    this.context,
  ) : super(const HelpState());

  final BuildContext context;

  void back() => Navigator.pop(context);

  void changePassowrd() {
    Navigator.pushNamed(
      context,
      Routes.changePassword,
    );
  }
}
