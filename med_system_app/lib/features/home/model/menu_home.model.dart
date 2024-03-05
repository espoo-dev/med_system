import 'package:distrito_medico/core/model/ui/menu_item.model.dart';
import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/features/event_procedures/pages/event_procedures_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          action: () {
            push(
                context,
                const EventProceduresPage(
                  backToHome: true,
                  initialFilter: InitialFilter.paid,
                ));
          }),
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
          action: () {
            push(
                context,
                const EventProceduresPage(
                  backToHome: true,
                  initialFilter: InitialFilter.unpaid,
                ));
          }),
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
