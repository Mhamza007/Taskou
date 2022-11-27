import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';

class LocationMapScreen extends StatelessWidget {
  const LocationMapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationMapCubit(),
      child: BlocBuilder<LocationMapCubit, LocationMapState>(
        builder: (context, state) {
          var cubit = context.read<LocationMapCubit>();

          return Container();
        },
      ),
    );
  }
}
