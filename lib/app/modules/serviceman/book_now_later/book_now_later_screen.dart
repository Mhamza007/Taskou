import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class BookNowLaterScreen extends StatelessWidget {
  const BookNowLaterScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => BookNowLaterCubit(
        context,
        data: data,
      ),
      child: BlocBuilder<BookNowLaterCubit, BookNowLaterState>(
        builder: (context, state) {
          var cubit = context.read<BookNowLaterCubit>();

          return Scaffold(
            backgroundColor: isDarkMode
                ? Res.colors.backgroundColorDark
                : Res.colors.backgroundColorLight2,
            appBar: AppBar(
              title: Text(Res.string.bookServiceman),
            ),
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              children: [
                Text(
                  Res.string.whenYouNeedServiceman,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32.0,
                  ),
                ),
                const SizedBox(height: 32),
                OutlineButton(
                  title: Res.string.now,
                  onPressed: cubit.bookNow,
                ),
                const SizedBox(height: 32),
                OutlineButton(
                  title: Res.string.later,
                  onPressed: cubit.bookLater,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
