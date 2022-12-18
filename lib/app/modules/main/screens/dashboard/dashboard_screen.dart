import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskou/app/app.dart';

import '../../../../../resources/resources.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(context),
        ),
        BlocProvider(
          create: (context) => FindServicemanCubit(context),
        ),
        BlocProvider(
          create: (context) => BookingsCubit(context),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(context),
        ),
      ],
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          var dashboardCubit = context.read<DashboardCubit>();

          var pages = [
            BlocConsumer<FindServicemanCubit, FindServicemanState>(
              listenWhen: (prev, curr) =>
                  prev.apiResponseStatus != curr.apiResponseStatus,
              listener: (context, state) {
                switch (state.apiResponseStatus) {
                  case ApiResponseStatus.failure:
                    Helpers.errorSnackBar(
                      context: context,
                      title: state.message,
                    );
                    break;
                  default:
                }
              },
              builder: (context, fsstate) {
                var cubit = context.read<FindServicemanCubit>();
                dashboardCubit.initFindServicemanCubit(cubit);

                return FindServicemanScreen(
                  cubit: cubit,
                  state: fsstate,
                  themeMode: state.themeMode,
                );
              },
            ),
            BlocConsumer<BookingsCubit, BookingsState>(
              listener: (context, bookingsstate) {},
              builder: (context, bookingsstate) {
                var cubit = context.read<BookingsCubit>();
                dashboardCubit.initBookingsCubit(cubit);

                return BookingsScreen(
                  cubit: cubit,
                  state: bookingsstate,
                  themeMode: state.themeMode,
                );
              },
            ),

            /// Profile Tab
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                // switch (state.apiResponseStatus) {
                //   case ApiResponseStatus.failure:
                //     Helpers.errorSnackBar(
                //       context: context,
                //       title: state.message,
                //     );
                //     break;
                //   default:
                // }
              },
              builder: (context, profileState) {
                var cubit = context.read<ProfileCubit>();
                dashboardCubit.initProfileCubit(cubit);

                return ProfileScreen(
                  cubit: cubit,
                  state: profileState,
                  themeMode: state.themeMode,
                  editMode: state.editMode,
                );
              },
            ),
          ];

          return Scaffold(
            key: dashboardCubit.scaffoldKey,
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  dashboardCubit.scaffoldKey.currentState?.openDrawer();
                },
                child: SvgPicture.asset(
                  Res.drawable.menu,
                  width: 24.0,
                  height: 24.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(state.currentPageTitle),
              actions: [
                state.selectedIndex == 2
                    ? eidtButton(
                        dashboardCubit,
                        state,
                      )
                    : themeButton(
                        dashboardCubit,
                        state,
                      ),
              ],
            ),
            body: pages[state.selectedIndex],
            drawer: SideMenu(
              userName: state.userName,
              phoneNumber: state.phoneNumber,
              imageUrl: state.imageUrl,
              homeTap: dashboardCubit.home,
              supportTap: dashboardCubit.support,
              helpTap: dashboardCubit.help,
              logoutTap: dashboardCubit.logout,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: dashboardCubit.onItemSelected,
              currentIndex: state.selectedIndex,
              items: [
                BottomNavigationBarItem(
                  label: Res.string.findServiceman,
                  icon: SvgPicture.asset(
                    Res.drawable.findServicemanUnselected,
                  ),
                  activeIcon: SvgPicture.asset(
                    Res.drawable.findServicemanSelected,
                  ),
                  tooltip: Res.string.findServiceman,
                ),
                BottomNavigationBarItem(
                  label: Res.string.bookings,
                  icon: SvgPicture.asset(
                    Res.drawable.bookingsUnselected,
                  ),
                  activeIcon: SvgPicture.asset(
                    Res.drawable.bookingsSelected,
                  ),
                  tooltip: Res.string.bookings,
                ),
                BottomNavigationBarItem(
                  label: Res.string.profile,
                  icon: SvgPicture.asset(
                    Res.drawable.profileUnselected,
                  ),
                  activeIcon: SvgPicture.asset(
                    Res.drawable.profileSelected,
                  ),
                  tooltip: Res.string.profile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget themeButton(
    DashboardCubit dashboardCubit,
    DashboardState dashboardState,
  ) {
    return GestureDetector(
      onTap: () {
        if (Res.appTheme.getThemeMode() == ThemeMode.light) {
          dashboardCubit.changeThemeMode(ThemeMode.dark);
        } else {
          dashboardCubit.changeThemeMode(ThemeMode.light);
        }
      },
      child: Center(
        child: SvgPicture.asset(
          dashboardState.themeMode == ThemeMode.dark
              ? Res.drawable.light
              : Res.drawable.dark,
        ).marginOnly(right: 12.0),
        // child: Text(
        //   dashboardState.themeMode == ThemeMode.dark
        //       ? Res.string.dark
        //       : Res.string.light,
        // ).marginOnly(right: 12.0),
      ),
    );
  }

  Widget eidtButton(
    DashboardCubit dashboardCubit,
    DashboardState dashboardState,
  ) {
    return GestureDetector(
      onTap: () {
        if (dashboardState.editMode) {
          dashboardCubit.saveEditing();
        } else {
          dashboardCubit.enableEditing();
        }
      },
      child: Center(
        child: Text(
          dashboardState.editMode ? Res.string.save : Res.string.edit,
        ).marginOnly(right: 12.0),
      ),
    );
  }
}
