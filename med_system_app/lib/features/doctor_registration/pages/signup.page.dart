import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_app_bar.widget.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field_password.widget.dart';
import 'package:distrito_medico/core/widgets/my_toast.widget.dart';
import 'package:distrito_medico/features/doctor_registration/store/signup.store.dart';
import 'package:distrito_medico/features/signin/page/signin.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpStore = GetIt.I.get<SignUpStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers.add(reaction<SignUpState>(
      (_) => signUpStore.signUpState,
      (state) {
        if (state == SignUpState.success) {
          CustomToast.show(
            context,
            type: ToastType.success,
            title: "Cadastrado com sucesso!",
            description: signUpStore.errorMessage,
          );
          to(context, const SignInPage());
        } else if (state == SignUpState.error) {
          CustomToast.show(
            context,
            type: ToastType.error,
            title: "Erro ao tentar realizar o cadastro",
            description: signUpStore.errorMessage,
          );
        }
      },
    ));
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Criar conta',
        hideLeading: true,
        image: null,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextFormField(
                    fontSize: 16,
                    label: 'E-mail',
                    placeholder: 'Digite seu e-mail',
                    inputType: TextInputType.emailAddress,
                    validators: const {
                      'required': true,
                      'minLength': 4,
                      'regex':
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                    },
                    onChanged: signUpStore.changeEmail,
                  ),
                  const SizedBox(height: 20),
                  MyTextFormFieldPassword(
                    label: 'Senha',
                    placeholder: 'Digite sua senha',
                    obscureText: true,
                    inputType: TextInputType.text,
                    validators: const {
                      'required': true,
                      'minLength': 6,
                    },
                    onChanged: signUpStore.changePassword,
                  ),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormFieldPassword(
                          label: 'Confirmar senha',
                          placeholder: 'Confirme sua senha',
                          obscureText: true,
                          inputType: TextInputType.text,
                          validators: const {
                            'required': true,
                            'minLength': 6,
                          },
                          onChanged: signUpStore.changeConfirmPassword,
                        ),
                        if (signUpStore.passwordsDoNotMatch)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 4.0),
                            child: Text(
                              'As senhas não coincidem.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                  const SizedBox(height: 24.0),
                  Center(child: Observer(builder: (_) {
                    return MyButtonWidget(
                      text: 'Cadastrar',
                      isLoading: signUpStore.signUpState == SignUpState.loading,
                      onTap: () async {
                        _formKey.currentState?.save();
                        if (_formKey.currentState!.validate()) {
                          await signUpStore.signUp();
                        }
                      },
                    );
                  })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
