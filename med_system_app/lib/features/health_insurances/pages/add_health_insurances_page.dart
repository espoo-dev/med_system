import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/my_app_bar.widget.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:med_system_app/core/widgets/my_text_form_field.widget.dart';
import 'package:med_system_app/features/hospitals/pages/hospital_page.dart';

class AddHealthInsurances extends StatefulWidget {
  const AddHealthInsurances({super.key});

  @override
  State<AddHealthInsurances> createState() => _AddHealthInsurancesState();
}

class _AddHealthInsurancesState extends State<AddHealthInsurances> {
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
        to(context, const HospitalPage());
      },
      child: Scaffold(
          appBar: const MyAppBar(
            title: 'Novo convênio',
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
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        fontSize: 16,
                        label: 'Nome do convênio',
                        placeholder: 'Digite o nome do convênio',
                        inputType: TextInputType.text,
                        validators: const {'required': true, 'minLength': 3},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Observer(builder: (_) {
                        return MyButtonWidget(
                          text: 'Cadastrar Convênio',
                          disabledColor: Colors.grey,
                          onTap: () {},
                        );
                      })),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
