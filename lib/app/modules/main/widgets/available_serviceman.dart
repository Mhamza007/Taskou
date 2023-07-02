import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskou/configs/configs.dart';

import '../../../../resources/resources.dart';

class AvailableServicemanItem extends StatelessWidget {
  const AvailableServicemanItem({
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Res.colors.materialColor,
        ),
      ),
      child: Column(
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
                        width: 48.0,
                        height: 48.0,
                        errorWidget: (context, url, error) {
                          return SvgPicture.asset(
                            Res.drawable.userAvatar,
                            width: 48.0,
                            height: 48.0,
                            fit: BoxFit.scaleDown,
                          );
                        },
                      ),
                    )
                  : SvgPicture.asset(
                      Res.drawable.userAvatar,
                      width: 48.0,
                      height: 48.0,
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
                  ],
                ).paddingSymmetric(
                  horizontal: 12.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text(
                  //   certified ? Res.string.certified : '',
                  //   style: TextStyle(
                  //     color: Res.colors.redColor,
                  //   ),
                  // ),
                  // const SizedBox(height: 8.0),
                  Text(
                    ratePerHour,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            jobs,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 8.0),
          RatingBar.builder(
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Res.colors.materialColor,
            ),
            allowHalfRating: true,
            onRatingUpdate: (value) {},
            ignoreGestures: true,
            itemSize: 16,
            initialRating: rating ?? 0,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: viewProfile,
                  child: Text(
                    Res.string.viewProfile,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
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
