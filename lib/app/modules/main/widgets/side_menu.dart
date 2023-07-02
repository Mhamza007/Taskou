import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.userName,
    required this.phoneNumber,
    this.imageUrl,
    this.homeTap,
    this.supportTap,
    this.helpTap,
    this.logoutTap,
  });

  final String userName;
  final String phoneNumber;
  final String? imageUrl;
  final Function()? homeTap;
  final Function()? supportTap;
  final Function()? helpTap;
  final Function()? logoutTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Res.colors.materialColor,
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white54,
                      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                          ? CachedNetworkImageProvider(
                              imageUrl!,
                            )
                          : null,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      phoneNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _drawerItem(
              title: Res.string.home,
              onTap: homeTap,
            ),
            _drawerItem(
              title: Res.string.support,
              onTap: supportTap,
            ),
            _drawerItem(
              title: Res.string.help,
              onTap: helpTap,
            ),
            _drawerItem(
              title: Res.string.logout,
              onTap: logoutTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required String title,
    Function()? onTap,
  }) =>
      ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
}
