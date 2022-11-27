import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(
        context,
        handymanData: data,
      ),
      child: BlocConsumer<ReviewCubit, ReviewState>(
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
            case ApiResponseStatus.success:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text(Res.string.appTitle),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(Res.string.ok),
                      ),
                    ],
                  );
                },
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          var cubit = context.read<ReviewCubit>();

          return AbsorbPointer(
            absorbing: state.loading,
            child: Scaffold(
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
                  Res.string.review,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${data['first_name'] ?? ''} ${data['last_name'] ?? ''}',
                    ),
                    const SizedBox(height: 16.0),
                    RatingBar.builder(
                      allowHalfRating: true,
                      glowColor: Res.colors.materialColor,
                      glow: false,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Res.colors.materialColor,
                        );
                      },
                      onRatingUpdate: cubit.onRatingUpdate,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: cubit.messageController,
                      decoration: InputDecoration(
                        hintText: Res.string.enterYourMessage,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      maxLines: 6,
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.maxFinite,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: cubit.postReview,
                        child: state.loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                Res.string.review,
                              ),
                      ),
                    )
                  ],
                ).paddingSymmetric(
                  horizontal: 40.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
