import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit(
    this.context,
  ) : super(const SupportState());

  final BuildContext context;

  void back() => Navigator.pop(context);

  Future<void> submit() async {}
}
