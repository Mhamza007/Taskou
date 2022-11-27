import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../resources/resources.dart';
import '../../../app.dart';

class BookingsItem extends StatelessWidget {
  const BookingsItem({
    super.key,
    required this.profileImage,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.ratePerHour,
    required this.status,
    this.scheduled,
    this.onTap,
  });

  final String profileImage;
  final String title;
  final String dateTime;
  final String location;
  final String ratePerHour;
  final String status;
  final String? scheduled;
  final Function()? onTap;

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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileImage.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        imageUrl: '${HTTPConfig.imageBaseURL}$profileImage',
                        width: 44.0,
                        height: 44.0,
                        fit: BoxFit.scaleDown,
                        errorWidget: (context, url, error) {
                          return SvgPicture.asset(
                            Res.drawable.userAvatar,
                            width: 44.0,
                            height: 44.0,
                            fit: BoxFit.scaleDown,
                          );
                        },
                      ),
                    )
                  : SvgPicture.asset(
                      Res.drawable.userAvatar,
                      width: 44.0,
                      height: 44.0,
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
                    const SizedBox(height: 4.0),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      location,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      ratePerHour,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 12.0,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: Res.colors.bookingsStatusColor,
                ),
              ),
            ],
          ).paddingAll(12.0),
          scheduled != null
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  child: Container(
                    width: double.maxFinite,
                    color: Res.colors.tabIndicatorColor,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      scheduled!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    ).onTap(onTap);
  }
}
