import 'package:flutter/material.dart';

class MenuItemModel {
  String label;
  IconData? icon;
  IconData? iconright;
  Function? action;
  Widget? image;
  String? description;
  double? emptySpaceHeight;
  Color? colorIcon;
  Color? backgroundColor;
  MenuItemModel(
      {required this.label,
      this.icon,
      this.action,
      this.image,
      this.description,
      this.emptySpaceHeight,
      this.iconright,
      this.colorIcon,
      this.backgroundColor});
}
