import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class SpeedometerMapScreen extends StatelessWidget {
  const SpeedometerMapScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;
    var radius = 52.0;

    return BlocProvider(
      create: (context) => SpeedometerMapCubit(
        context,
        data: data,
      ),
      child: BlocConsumer<SpeedometerMapCubit, SpeedometerMapState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<SpeedometerMapCubit>();
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: state.initialCameraPosition,
                  onMapCreated: cubit.onMapCreated,
                  myLocationEnabled: true,
                ),
                Positioned(
                  right: 8.0,
                  top: 8.0,
                  child: SafeArea(
                    child: CircleAvatar(
                      radius: radius + 2,
                      backgroundColor: Res.colors.materialColor,
                      child: CircleAvatar(
                        radius: radius,
                        backgroundColor: darkMode
                            ? Res.colors.darkBottomNavBarColor
                            : Res.colors.whiteColor,
                        child: Text(
                          state.speed ?? '0.0',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: darkMode
                                ? Res.colors.textColorDark
                                : Res.colors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: state.trackingMode == TrackingMode.childMode
                ? Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Res.colors.materialColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.childModeData!.name ?? '',
                              style: TextStyle(
                                color: darkMode
                                    ? Res.colors.textColorDark
                                    : Res.colors.textColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: state.childModeData!.relation ?? '',
                                    style: TextStyle(
                                      color: darkMode
                                          ? Res.colors.textColorDark
                                          : Res.colors.textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${Res.string.of} ',
                                    style: TextStyle(
                                      color: darkMode
                                          ? Res.colors.textColorDark
                                          : Res.colors.textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        state.childModeData!.relatedName ?? '',
                                    style: TextStyle(
                                      color: Res.colors.materialColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: cubit.stopLocationService,
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0.0),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 20.0,
                              ),
                            ),
                          ),
                          child: Text(
                            Res.string.stop,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
