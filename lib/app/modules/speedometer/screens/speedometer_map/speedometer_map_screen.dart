import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                Res.string.tracking,
              ),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: state.initialCameraPosition,
                  onMapCreated: cubit.onMapCreated,
                  myLocationEnabled:
                      state.trackingMode == TrackingMode.childMode,
                  markers: state.markers,
                ),
                if (state.trackingMode == TrackingMode.childMode)
                  Positioned(
                    right: 8.0,
                    top: 8.0,
                    child: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Res.colors.materialColor,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Res.colors.whiteColor,
                          ),
                          child: Text(
                            state.speed ?? '0.0',
                            style: TextStyle(
                              fontSize: 28.0,
                              color: darkMode
                                  ? Res.colors.chestnutRedColor
                                  : Res.colors.chestnutRedColor,
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
                : state.trackingMode == TrackingMode.trackHandyman
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Res.drawable.userAvatar,
                          ),
                          title: state.handymanDetails?.firstName != null
                              ? Text(
                                  '${state.handymanDetails!.firstName!} ${state.handymanDetails?.lastName ?? ''} ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          subtitle: state.handymanDetails?.city != null ||
                                  state.handymanDetails?.province != null
                              ? Text(
                                  '${state.handymanDetails?.city ?? ''} ${state.handymanDetails?.province ?? ''}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : const SizedBox.shrink(),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: cubit.call,
                                icon: SvgPicture.asset(
                                  Res.drawable.phone,
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                              IconButton(
                                onPressed: cubit.chat,
                                icon: SvgPicture.asset(
                                  Res.drawable.message,
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
          );
        },
      ),
    );
  }
}
