import 'package:distrito_medico/core/model/ui/menu_item.model.dart';
import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuHomeMedicalSfhitModel {
  MenuHomeMedicalSfhitModel();

  List<MenuItemModel> buildMenuHome(String total, String totalpaid,
      String totalUnpaid, BuildContext context) {
    var menufinancial = [
      MenuItemModel(
          image: SvgPicture.asset(
            iconHeartTickHomeAsset,
            width: 42,
            height: 42,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          backgroundColor: const Color(0xff45B3CB),
          label: totalpaid,
          description: 'Recebido',
          action: () {
            push(
                context,
                const MedicalShiftsPage(
                  backToHome: true,
                  initialFilter: InitialFilter.paid,
                ));
          }),
      MenuItemModel(
          backgroundColor: const Color(0xffED7390),
          label: totalUnpaid,
          description: 'A receber',
          image: SvgPicture.asset(
            iconHeartRemoveHomeAsset,
            width: 42,
            height: 42,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          action: () {
            push(
                context,
                const MedicalShiftsPage(
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
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          action: () {
            push(
                context,
                const MedicalShiftsPage(
                  backToHome: true,
                  initialFilter: InitialFilter.all,
                ));
          }),
    ];
    return menufinancial;
  }
}
