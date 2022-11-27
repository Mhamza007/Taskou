import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit(
    this.context,
  ) : super(const TrackingState()) {
    _trackingServiceApi = TrackingServiceApi();
    _userStorage = UserStorage();

    searchController = TextEditingController();
    searchController.addListener(() {
      emit(
        state.copyWith(
          isSearching: searchController.text.isNotEmpty,
        ),
      );

      filter();
    });

    getTrackingData();
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late TrackingServiceApi _trackingServiceApi;
  late TextEditingController searchController;

  void back() => Navigator.pop(context);

  Future<void> getTrackingData() async {
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null) {
          var response = await _trackingServiceApi.getTrackingData(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                trackingData: response?.data,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
                trackingData: [],
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
              trackingData: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
            trackingData: [],
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          trackingData: [],
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          trackingData: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
          trackingData: [],
        ),
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  void filter() {
    if (state.trackingData != null && state.trackingData!.isNotEmpty) {
      var query = searchController.text;
      var searchList = <TrackingResponseData>[];
      for (var element in state.trackingData!) {
        if (element.name?.toLowerCase().contains(query.toLowerCase()) == true) {
          searchList.add(element);
        } else {
          searchList.remove(element);
        }
      }
      emit(
        state.copyWith(
          filterData: searchList,
        ),
      );
    }
  }

  Future<void> shareItem(TrackingResponseData item) async {
    if (item.code != null) {
      try {
        await Share.share(
          item.code!,
          subject: item.name,
        );
      } catch (e) {
        Helpers.errorSnackBar(
          context: context,
          title: 'Error while sharing code',
        );
      }
    } else {
      Helpers.errorSnackBar(
        context: context,
        title: 'The code is null',
      );
    }
  }

  Future<void> deleteItem(TrackingResponseData item) async {}

  Future<void> openItem(TrackingResponseData item) async {
    Navigator.pushNamed(
      context,
      Routes.speedometerMap,
    );
  }
}
