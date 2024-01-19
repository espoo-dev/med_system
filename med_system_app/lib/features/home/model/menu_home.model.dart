import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_system_app/core/model/ui/menu_item.model.dart';
import 'package:med_system_app/core/theme/icons.dart';

class MenuHomeModel {
  MenuHomeModel();

  List<MenuItemModel> buildMenuHome(BuildContext context) {
    var menufinancial = [
      MenuItemModel(
          image: SvgPicture.asset(
            iconHeartTickHomeAsset,
            width: 42,
            height: 42,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xff45B3CB),
          label: 'R\$15.480,00',
          description: 'Recebido',
          action: () {}),
      MenuItemModel(
          backgroundColor: const Color(0xffED7390),
          label: 'R\$32.587,21',
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
          label: 'R\$32.587,21',
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
