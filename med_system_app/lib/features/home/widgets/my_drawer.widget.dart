import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_system_app/core/theme/icons.dart';
import 'package:med_system_app/features/health_insurances/pages/add_health_insurances_page.dart';
import 'package:med_system_app/features/hospitals/pages/hospital_page.dart';
import 'package:med_system_app/features/patients/pages/patient_page.dart';
import 'package:med_system_app/features/procedures/pages/add_procedure_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Olá"),
            accountEmail: Text("Bem-vindo(a)"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PatientPage()));
            },
            title: const Text(
              "Plantões",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuPlantao,
              width: 30,
              height: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
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
              color: Theme.of(context).colorScheme.primary,
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
              "Hospital",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuHospital,
              width: 30,
              height: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddHealthInsurances()));
            },
            title: const Text(
              "Convênios",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuConvenio,
              width: 30,
              height: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProcedurePage()));
            },
            title: const Text(
              "Procedimentos",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: SvgPicture.asset(
              iconMenuConvenio,
              width: 30,
              height: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              SystemNavigator.pop();
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
