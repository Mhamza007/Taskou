import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'serviceman_profile_state.dart';

class ServicemanProfileCubit extends Cubit<ServicemanProfileState> {
  ServicemanProfileCubit(
    this.context, {
    required this.data,
  }) : super(const ServicemanProfileState()) {
    BrowseServiceData browseServiceData = BrowseServiceData.fromJson(
      data['data'],
    );

    emit(
      state.copyWith(
        title:
            '${browseServiceData.firstName ?? ''} ${browseServiceData.lastName ?? ''}',
        browseServiceData: browseServiceData,
      ),
    );
  }

  final BuildContext context;
  final Map<String, dynamic> data;

  void back() => Navigator.pop(context);

  void book() {
    Navigator.pushNamed(
      context,
      Routes.bookNowLater,
      arguments: {
        'data': state.browseServiceData?.toJson(),
        'title': data['title'],
      },
    );
  }
}
