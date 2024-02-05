import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_system_app/features/patients/pages/patient_page.dart';

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
            },
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.home,
            ),
          ),
          const ListTile(
            title: Text(
              "Rate",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.star,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PatientPage()));
            },
            title: const Text(
              "Contact",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              Icons.contact_page,
            ),
          ),
          const ListTile(
            title: Text(
              "Share",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.share,
            ),
          ),
          ListTile(
            onTap: () {
              SystemNavigator.pop();
            },
            title: const Text(
              "Exit",
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
