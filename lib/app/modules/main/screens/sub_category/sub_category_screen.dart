import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../app.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({
    super.key,
    required this.title,
    this.subCategoryResponse,
    this.sub2CategoryResponse,
  });

  final String title;
  final dynamic subCategoryResponse;
  final dynamic sub2CategoryResponse;

  @override
  Widget build(BuildContext context) {
    final darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(context),
        ),
        BlocProvider<SubCategoryCubit>(
          create: (context) => SubCategoryCubit(
            context,
            title,
            subCategoryResponse,
          ),
        ),
      ],
      child: BlocBuilder<SubCategoryCubit, SubCategoryState>(
        builder: (context, state) {
          var cubit = context.read<SubCategoryCubit>();

          return Scaffold(
            backgroundColor: darkMode
                ? Res.colors.backgroundColorDark
                : Res.colors.backgroundColorLight2,
            appBar: AppBar(
              leading: InkWell(
                onTap: cubit.back,
                child: SvgPicture.asset(
                  Res.drawable.back,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(
                state.title,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              centerTitle: true,
            ),
            body: PageView(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: cubit.onPageChanged,
              children: [
                SubCategoryPage(
                  subCategoriesList: state.subCategoriesList,
                  onItemTap: cubit.onSubCategoryClicked,
                ),
                Sub2CategoryPage(
                  sub2CategoriesList: state.sub2CategoriesList,
                  onItemTap: cubit.onSub2CategoryClicked,
                ),
                Sub3CategoryPage(
                  sub3CategoriesList: state.sub3CategoriesList,
                  onItemTap: cubit.onSub3CategoryClicked,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
