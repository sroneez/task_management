import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/update_profile_screen.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile = false});

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!fromUpdateProfile) {
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rabbil Hassan',
                    style: textStyle.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'rabbiil@gmail.com',
                    style: textStyle.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
