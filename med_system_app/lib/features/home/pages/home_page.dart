import 'package:flutter/material.dart';
import 'package:med_system_app/core/widgets/my_horizontal_menu.widget.dart';
import 'package:med_system_app/features/home/model/menu_home.model.dart';
import 'package:med_system_app/features/home/widgets/build_header.widget.dart';
import 'package:med_system_app/features/home/widgets/build_welcome.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuHomeModel menuHomeModel = MenuHomeModel();
  _buildPageBody(BuildContext context) {
    return ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          const HeaderHomeWidget(),
          const WelcomeWidget(),
          const SizedBox(height: 22),
          HorizontalMenuWidget(
            menuItems: menuHomeModel.buildMenuHome(context),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _buildPageBody(context),
        ],
      ),
    );
  }
}
