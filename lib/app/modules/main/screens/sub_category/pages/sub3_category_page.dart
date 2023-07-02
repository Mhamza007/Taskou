import 'package:flutter/material.dart';
import 'package:taskou/sdk/models/models.dart';

import '../../../../../../../../resources/resources.dart';

class Sub3CategoryPage extends StatelessWidget {
  const Sub3CategoryPage({
    super.key,
    this.sub3CategoriesList,
    this.onItemTap,
  });

  final List<Sub3CategoriesData>? sub3CategoriesList;
  final Function(Sub3CategoriesData sub3CategoriesData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return sub3CategoriesList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: sub3CategoriesList!.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12.0),
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              var item = sub3CategoriesList![index];

              return GestureDetector(
                onTap: onItemTap != null
                    ? () {
                        onItemTap!(
                          sub3CategoriesList![index],
                        );
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: darkMode
                        ? Res.colors.backgroundColorDark
                        : Res.colors.backgroundColorLight,
                  ),
                  child: Text(
                    item.subSubSubCatName ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
