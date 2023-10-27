import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskou/configs/configs.dart';

import '../../../../../resources/resources.dart';
import '../../../../../sdk/sdk.dart';
import '../../../../app.dart';

class ServicemanProfileScreen extends StatelessWidget {
  const ServicemanProfileScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicemanProfileCubit(
        context,
        data: data,
      ),
      child: BlocBuilder<ServicemanProfileCubit, ServicemanProfileState>(
        builder: (context, state) {
          var cubit = context.read<ServicemanProfileCubit>();

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
                state.title,
              ),
            ),
            body: ListView(
              children: [
                ServicemanProfile(
                  imageUrl: state.browseServiceData?.profileImg,
                  title:
                      '${state.browseServiceData?.firstName} ${state.browseServiceData?.lastName}',
                  location:
                      '${state.browseServiceData?.city}, ${state.browseServiceData?.province}',
                  certified:
                      state.browseServiceData?.certFront?.isNotEmpty == true,
                  ratePerHour:
                      state.browseServiceData?.price?.isNotEmpty == true
                          ? '${state.browseServiceData?.price}\$/hour'
                          : 'NA',
                  jobs: '${state.browseServiceData?.getJobs ?? 0} Jobs',
                  rating: state.browseServiceData?.ratings,
                  viewProfile: () {},
                  book: cubit.book,
                ),
              ]
                ..addIf(
                  state.workPhotos != null,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Res.string.workPhotos,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ).marginSymmetric(horizontal: 16.0),
                      const SizedBox(height: 16.0),
                      if (state.workPhotos != null)
                        SizedBox(
                          height: 120.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.workPhotos!.length,
                            itemBuilder: (context, index) {
                              var workPhoto = state.workPhotos![index];

                              return workPhoto?.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        height: 120.0,
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Image.network(
                                          '${HTTPConfig.imageBaseURL}${workPhoto!.image!}',
                                        ),
                                      ),
                                    ).onTap(
                                      () {
                                        Get.to(
                                          ImagePreview(
                                            imageUrl:
                                                '${HTTPConfig.imageBaseURL}${workPhoto.image!}',
                                          ),
                                        );
                                      },
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                    ],
                  ),
                )
                ..addIf(
                  state.handymanReviews != null,
                  Text(
                    Res.string.reviews,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ).marginSymmetric(horizontal: 16.0).marginOnly(top: 16.0),
                )
                ..addAllIf(
                  state.handymanReviews != null,
                  state.handymanReviews
                          ?.map(
                            (handymanReview) => HandymanReviewWidget(
                              cubit: cubit,
                              handymanReview: handymanReview,
                            ),
                          )
                          .toList() ??
                      [],
                ),
            ),
          );
        },
      ),
    );
  }
}

class HandymanReviewWidget extends StatelessWidget {
  const HandymanReviewWidget({
    super.key,
    required this.cubit,
    required this.handymanReview,
  });

  final ServicemanProfileCubit cubit;
  final HandymanReviewData handymanReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xfff2f1f7),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Res.colors.materialColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (handymanReview.comentedBy != null)
            Text(
              handymanReview.comentedBy!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          if (handymanReview.rating != null &&
              handymanReview.rating!.isNotEmpty)
            RatingBar.builder(
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Res.colors.materialColor,
              ),
              allowHalfRating: true,
              onRatingUpdate: (value) {},
              ignoreGestures: true,
              itemSize: 24,
              initialRating: cubit.getRating(handymanReview.rating),
            ).marginSymmetric(
              vertical: 8.0,
            ),
          Text(
            handymanReview.message ?? '',
          ),
        ],
      ).paddingAll(12.0),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: Get.back,
          child: SvgPicture.asset(
            Res.drawable.back,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          Res.string.workPhotos,
        ),
      ),
      body: InteractiveViewer(
        maxScale: 4.0,
        child: Center(
          child: Image.network(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
