import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}