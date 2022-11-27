import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class TrackingItem extends StatelessWidget {
  const TrackingItem({
    super.key,
    required this.title,
    required this.relation,
    required this.subtitle,
    this.shareCode,
    this.delete,
    this.onTap,
  });

  final String title;
  final String relation;
  final String subtitle;
  final Function()? shareCode;
  final Function()? delete;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      relation,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 12.0,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: shareCode,
                        child: Text(
                          Res.string.shareCode,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: delete,
                        child: Text(
                          Res.string.delete,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(12.0),
    ).onTap(onTap);
  }
}
