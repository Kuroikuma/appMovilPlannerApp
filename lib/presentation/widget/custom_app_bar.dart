import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final double height;
  final Widget? leading;
  final Widget? flexibleSpace;
  final bool centerTitle;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
    this.height = kToolbarHeight,
    this.leading,
    this.flexibleSpace,
    this.centerTitle = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.primary,
      leading:
          showBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                color: Colors.white,
              )
              : leading,
      actions: actions,
      flexibleSpace: flexibleSpace,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
