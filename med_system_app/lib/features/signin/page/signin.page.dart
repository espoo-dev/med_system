import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/theme/icons.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:med_system_app/core/widgets/my_text_form_field.widget.dart';
import 'package:med_system_app/core/widgets/my_text_form_field_password.widget.dart';
import 'package:med_system_app/core/widgets/my_toast.widget.dart';
import 'package:med_system_app/features/home/pages/home_page.dart';
import 'package:med_system_app/features/signin/store/signin.store.dart';
import 'package:mobx/mobx.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInStore = GetIt.I.get<SignInStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers
        .add(reaction<SignInState>((_) => signInStore.signInState, (state) {
      if (state == SignInState.success) {
        to(context, const HomePage());
      } else if (state == SignInState.error) {
        CustomToast.show(context,
            type: ToastType.error,
            title: "Erro ao tentar realizar o login",
            description: signInStore.errorMessage);
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      iconHeaderLoginAsset,
                    ),
                  ),
                  const SizedBox(height: 27),
                  const Text("Seu melhor assistente médico",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 10),
                  const Text("Bem-vindo(a)!",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  const SizedBox(height: 20),
                  MyTextFormField(
                    fontSize: 16,
                    label: 'E-mail',
                    placeholder: 'Digite seu email',
                    inputType: TextInputType.emailAddress,
                    validators: const {
                      'required': true,
                      'minLength': 4,
                      'regex':
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                    },
                    onChanged: signInStore.changeEmail,
                  ),
                  const SizedBox(height: 20),
                  MyTextFormFieldPassword(
                      label: 'Senha',
                      placeholder: 'Digite sua senha',
                      obscureText: true,
                      inputType: TextInputType.text,
                      validators: const {
                        'required': true,
                        'minLength': 4,
                      },
                      onChanged: signInStore.changePassword),
                  const SizedBox(height: 24.0),
                  Center(child: Observer(builder: (_) {
                    return MyButtonWidget(
                      text: 'Entrar',
                      isLoading: signInStore.signInState == SignInState.loading,
                      onTap: () async {
                        _formKey.currentState?.save();
                        if (_formKey.currentState!.validate()) {
                          await signInStore.signIn(
                              signInStore.email, signInStore.password);
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

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }
}
