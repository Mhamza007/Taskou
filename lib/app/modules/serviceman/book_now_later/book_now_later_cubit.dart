import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';

part 'book_now_later_state.dart';

class BookNowLaterCubit extends Cubit<BookNowLaterState> {
  BookNowLaterCubit(
    this.context, {
    required this.data,
  }) : super(const BookNowLaterState());

  final BuildContext context;
  final Map<String, dynamic> data;

  void bookNow() {
    Navigator.pushNamed(
      context,
      Routes.bookServiceman,
      arguments: {
        'data': data['data'],
        'title': data['title'],
        'type': BookServicemanType.now,
      },
    );
  }

  void bookLater() {
    Navigator.pushNamed(
      context,
      Routes.bookServiceman,
      arguments: {
        'data': data['data'],
        'title': data['title'],
        'type': BookServicemanType.later,
      },
    );
  }
}
