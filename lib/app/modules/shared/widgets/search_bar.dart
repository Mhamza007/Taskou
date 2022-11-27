import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/resources.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onChanged,
    this.hint,
    this.autoFocus = false,
  });

  final TextEditingController controller;
  final Function(String string)? onSubmitted;
  final Function(String string)? onChanged;
  final String? hint;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: darkMode
            ? Res.colors.darkSearchBackgroundBarColor
            : Res.colors.lightSearchBackgroundBarColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Res.colors.searchBarShadowColor,
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: darkMode
              ? Res.colors.darkSearchBackgroundColor
              : Res.colors.lightSearchBackgroundColor,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Res.drawable.search,
              color: darkMode
                  ? Res.colors.darkSearchHintColor
                  : Res.colors.lightSearchHintColor,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                autofocus: autoFocus,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                style: TextStyle(
                  color: darkMode
                      ? Res.colors.textColorDark
                      : Res.colors.textColor,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hint ?? Res.string.search,
                  hintStyle: TextStyle(
                    color: darkMode
                        ? Res.colors.darkSearchHintColor
                        : Res.colors.lightSearchHintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
