import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get/get.dart';

import '../../../../../../../configs/configs.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../sdk/sdk.dart';
import '../../../../../../app.dart';

class FindServicemanScreen extends StatelessWidget {
  const FindServicemanScreen({
    super.key,
    required this.cubit,
    required this.state,
    this.themeMode,
  });

  final FindServicemanCubit cubit;
  final FindServicemanState state;
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    bool darkMode = themeMode == ThemeMode.dark;
    List<CategoriesResponseData>? resultList =
        state.isSearching ? state.filterList : state.categories;

    return Container(
      color: darkMode
          ? Res.colors.backgroundColorDark
          : Res.colors.backgroundColorLight2,
      child: Column(
        children: [
          /// Search bar
          Container(
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
                      controller: cubit.searchController,
                      style: TextStyle(
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: Res.string.whatDoYouNeed,
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
          ),
          Expanded(
            child: resultList == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: resultList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      var item = resultList[index];

                      return GestureDetector(
                        onTap: () => cubit.onItemTap(item),
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkMode
                                ? Res.colors.darkGridItemBgColor
                                : Res.colors.lightGridItemBgColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      '${HTTPConfig.baseURL}${item.categoryImage}',
                                  progressIndicatorBuilder: (
                                    context,
                                    url,
                                    downloadProgress,
                                  ) {
                                    return CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                  height: 48,
                                  width: 48,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  item.categoryName ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: darkMode
                                        ? Res.colors.textColorDark
                                        : Res.colors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
