import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/features/event_procedures/pages/event_procedures_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomAppBar extends StatefulWidget {
  final bool visible;

  const MyBottomAppBar({super.key, this.visible = false});

  @override
  State<MyBottomAppBar> createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                iconMenuPlantao,
                width: 24,
                height: 24,
              ),
              onPressed: () {
                push(context, const EventProceduresPage());
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                iconMenuPatient,
                width: 24,
                height: 24,
              ),
              onPressed: () {
                push(context, const MedicalShiftsPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
