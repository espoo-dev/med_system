import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hideLeading;
  final Widget? image;
  final bool? refresh;
  final List<Widget>? trailingIcons;
  final List<VoidCallback>? onTrailingPressed;
  final VoidCallback? onPressed;

  const MyAppBar({
    super.key,
    this.title = "",
    this.hideLeading = false,
    this.refresh = false,
    required this.image,
    this.onPressed,
    this.trailingIcons,
    this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: image ??
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
      centerTitle: true,
      elevation: 0,
      leading: hideLeading
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
            ),
      actions: trailingIcons != null && trailingIcons!.isNotEmpty
          ? trailingIcons!
              .asMap()
              .entries
              .map(
                (entry) => IconButton(
                  icon: entry.value,
                  onPressed: onTrailingPressed?[entry.key] ?? () {},
                ),
              )
              .toList()
          : [],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
