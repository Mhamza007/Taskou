import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskou/configs/configs.dart';

import '../../../../resources/resources.dart';

class ServicemanProfile extends StatelessWidget {
  const ServicemanProfile({
    super.key,
    this.imageUrl,
    required this.title,
    required this.location,
    required this.certified,
    required this.ratePerHour,
    required this.jobs,
    required this.rating,
    this.viewProfile,
    this.book,
  });

  final String? imageUrl;
  final String title;
  final String location;
  final String ratePerHour;
  final String jobs;
  final bool certified;
  final double? rating;
  final Function()? viewProfile;
  final Function()? book;

  @override
  Widget build(BuildContext context) {
    var imageSize = 60.0;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUrl != null && imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: '${HTTPConfig.imageBaseURL}$imageUrl',
                        width: imageSize,
                        height: imageSize,
                        errorWidget: (context, url, error) {
                          return SvgPicture.asset(
                            Res.drawable.userAvatar,
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.scaleDown,
                          );
                        },
                      ),
                    )
                  : SvgPicture.asset(
                      Res.drawable.userAvatar,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.scaleDown,
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${Res.string.rate}: $ratePerHour',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 12.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    certified ? Res.string.certified : '',
                    style: TextStyle(
                      color: Res.colors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          RatingBar.builder(
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Res.colors.materialColor,
            ),
            allowHalfRating: true,
            onRatingUpdate: (value) {},
            ignoreGestures: true,
            itemSize: 24,
            initialRating: rating ?? 0,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: ElevatedButton(
                  onPressed: book,
                  child: Text(
                    Res.string.book,
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(12.0),
    );
  }
}
