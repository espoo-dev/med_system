import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_system_app/core/model/ui/menu_item.model.dart';
import 'package:med_system_app/core/theme/icons.dart';

class MenuHomeModel {
  MenuHomeModel();

  List<MenuItemModel> buildMenuHome(String total, String totalPayd,
      String totalUnpayd, BuildContext context) {
    var menufinancial = [
      MenuItemModel(
          image: SvgPicture.asset(
            iconHeartTickHomeAsset,
            width: 42,
            height: 42,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xff45B3CB),
          label: totalPayd,
          description: 'Recebido',
          action: () {}),
      MenuItemModel(
          backgroundColor: const Color(0xffED7390),
          label: totalUnpayd,
          description: 'A receber',
          image: SvgPicture.asset(
            iconHeartRemoveHomeAsset,
            width: 42,
            height: 42,
            color: Colors.white,
          ),
          action: () {}),
      MenuItemModel(
          backgroundColor: const Color(0xff6FB1A1),
          label: total,
          description: 'Total',
          image: SvgPicture.asset(
            iconMedicationAsset,
            width: 42,
            height: 42,
            color: Colors.white,
          ),
          action: () {}),
    ];
    return menufinancial;
  }
}
