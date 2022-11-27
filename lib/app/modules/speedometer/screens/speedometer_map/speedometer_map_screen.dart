import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app.dart';

class SpeedometerMapScreen extends StatelessWidget {
  const SpeedometerMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeedometerMapCubit(context),
      child: BlocConsumer<SpeedometerMapCubit, SpeedometerMapState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<SpeedometerMapCubit>();
          return Scaffold(
            // appBar: AppBar(),
            body: GoogleMap(
              initialCameraPosition: state.initialCameraPosition,
              onMapCreated: cubit.onMapCreated,
              myLocationEnabled: true,
            ),
          );
        },
      ),
    );
  }
}
