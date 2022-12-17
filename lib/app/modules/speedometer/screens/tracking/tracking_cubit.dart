import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
                message: response?.message ?? Res.string.success,
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

  void goToAddChild() async {
    var addChild = await Navigator.pushNamed(
      context,
      Routes.addChild,
    );
    if (addChild == true) {
      getTrackingData();
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

  Future<void> deleteItem(TrackingResponseData item) async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            Res.string.delete,
            style: TextStyle(
              color: Res.colors.redColor,
            ),
          ),
          content: Text(
            '${item.name} will be deleted',
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                Res.string.cancel,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text(
                Res.string.delete,
              ),
              onPressed: () {
                Navigator.pop(context);
                deleteChild(item);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteChild(TrackingResponseData item) async {
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
          var response = await _trackingServiceApi.deleteChild(
            userToken: userToken,
            childId: item.id ?? '',
          );

          if (response?.statusCode == 200) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                message: response?.message ?? Res.string.success,
              ),
            );
            getTrackingData();
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
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

  Future<void> openItem(TrackingResponseData item) async {
    Navigator.pushNamed(
      context,
      Routes.speedometerMap,
      arguments: {
        'data': item,
        'mode': TrackingMode.relativeMode,
      },
    );
  }
}
