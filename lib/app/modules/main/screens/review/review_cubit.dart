import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../db/db.dart';
import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(
    this.context, {
    required this.handymanData,
  }) : super(const ReviewState()) {
    _bookingsApi = BookingsApi();
    _userStorage = UserStorage();

    messageController = TextEditingController();
  }

  final BuildContext context;
  final Map handymanData;
  late BookingsApi _bookingsApi;
  late UserStorage _userStorage;
  late TextEditingController messageController;

  void back() {
    Navigator.pop(context);
  }

  void onRatingUpdate(double rating) {
    emit(
      state.copyWith(
        rating: rating,
      ),
    );
  }

  Future<void> postReview() async {
    try {
      if (state.rating <= 0) {
        // Assign rating
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.pleaseAssignRatings,
          ),
        );
      } else if (messageController.text.isEmpty) {
        // Type a message
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.pleaseEnterYourMessage,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loading: true,
          ),
        );

        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          var userToken = _userStorage.getUserToken();
          if (userToken != null) {
            var response = await _bookingsApi.postReview(
              userToken: userToken,
              reviewData: {
                'message': messageController.text,
                'handyman_id': handymanData['handyman_id'],
                'points': state.rating,
              },
            );

            if (response?.statusCode == 200) {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.success,
                  message: response?.message ?? Res.string.success,
                ),
              );
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
}
