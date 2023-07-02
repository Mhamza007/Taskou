import 'package:flutter/material.dart';
import 'package:taskou/sdk/models/models.dart';

import '../../../../../../../../resources/resources.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({
    super.key,
    this.subCategoriesList,
    this.onItemTap,
  });

  final List<SubCategoriesData>? subCategoriesList;
  final Function(SubCategoriesData subCategoriesData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return subCategoriesList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemCount: subCategoriesList!.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12.0),
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              var item = subCategoriesList![index];

              return GestureDetector(
                onTap: onItemTap != null
                    ? () {
                        onItemTap!(
                          subCategoriesList![index],
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
                    item.subCategory ?? '',
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
