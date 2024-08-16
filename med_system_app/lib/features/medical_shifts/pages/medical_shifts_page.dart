import 'package:distrito_medico/core/widgets/ext_fab.widget.dart';
import 'package:distrito_medico/core/widgets/fab.widget.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/add_medical_shift_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/utils/navigation_utils.dart';

enum InitialFilter { paid, unpaid, all }

enum Actions { pay, delete }

class MedicalShiftsPage extends StatefulWidget {
  final bool backToHome;
  final InitialFilter? initialFilter;

  const MedicalShiftsPage(
      {super.key, this.backToHome = false, this.initialFilter});

  @override
  State<MedicalShiftsPage> createState() => _MedicalShiftsPageState();
}

class _MedicalShiftsPageState extends State<MedicalShiftsPage> {
  bool isFab = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    debugPrint('initstate');
    _scrollController.addListener(() {
      showFabButton();
    });
  }

  showFabButton() {
    if (_scrollController.offset > 50) {
      setState(() {
        isFab = true;
      });
    } else {
      setState(() {
        isFab = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {}
        to(context, const HomePage());
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Plantões',
          hideLeading: true,
          image: null,
        ),
        floatingActionButton: isFab
            ? buildFAB(context, () {
                to(context, const AddMedicalShiftPage());
              })
            : buildExtendedFAB(
                context,
                "Novo procedimento",
                () {
                  to(context, const AddMedicalShiftPage());
                },
              ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
