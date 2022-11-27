import 'package:flutter/material.dart';
import 'package:taskou/sdk/models/models.dart';

import '../../../../../../../../resources/resources.dart';

class Sub2CategoryPage extends StatelessWidget {
  const Sub2CategoryPage({
    super.key,
    this.sub2CategoriesList,
    this.onItemTap,
  });

  final List<Sub2CategoriesData>? sub2CategoriesList;
  final Function(Sub2CategoriesData sub2CategoriesData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return sub2CategoriesList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: sub2CategoriesList!.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12.0),
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              var item = sub2CategoriesList![index];

              return GestureDetector(
                onTap: onItemTap != null
                    ? () {
                        onItemTap!(
                          sub2CategoriesList![index],
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
                    item.subSubCatName ?? '',
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
