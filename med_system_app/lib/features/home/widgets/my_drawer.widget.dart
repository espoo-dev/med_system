import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/features/health_insurances/pages/health_insurances_page.dart';
import 'package:distrito_medico/features/hospitals/pages/hospital_page.dart';
import 'package:distrito_medico/features/medical_shifts/pages/medical_shifts_page.dart';
import 'package:distrito_medico/features/patients/pages/patient_page.dart';
import 'package:distrito_medico/features/procedures/pages/procedures_page.dart';
import 'package:distrito_medico/features/signin/page/signin.page.dart';
import 'package:distrito_medico/features/signin/store/signin.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final signInStore = GetIt.I.get<SignInStore>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Olá"),
            accountEmail:
                Text(signInStore.currentUser?.resourceOwner?.email ?? ""),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicalShiftsPage()));
            },
            title: const Text(
              "Plantões",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(iconMenuPlantao,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PatientPage()));
            },
            title: const Text(
              "Pacientes",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuPatient,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HospitalPage()));
            },
            title: const Text(
              "Hospitais",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuHospital,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HealthInsurancePage()));
            },
            title: const Text(
              "Convênios",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuConvenio,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProcedurePage()));
            },
            title: const Text(
              "Procedimentos",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(iconMenuProcedure,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                )),
          ),
          ListTile(
            onTap: () {
              signInStore.forceLogout();
              to(context, const SignInPage());
            },
            title: const Text(
              "Sair",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
    );
  }
}
