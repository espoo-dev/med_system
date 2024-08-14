import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:flutter/material.dart';

class AddMedicalShiftPage extends StatefulWidget {
  const AddMedicalShiftPage({super.key});

  @override
  State<AddMedicalShiftPage> createState() => _AddMedicalShiftPageState();
}

class _AddMedicalShiftPageState extends State<AddMedicalShiftPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {}
        //to(context, const MedicalShiftPage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Novo Plantão',
            hideLeading: true,
            image: null,
          ),
          body: form(context)),
    );
  }

  Widget form(BuildContext context) {
    return ListView(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 20, top: 30),
            child: Form(
              key: _formKey,
              child: const Column(
                children: [],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
