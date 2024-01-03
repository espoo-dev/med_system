import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/modules/signin/store/signin.store.dart';
import 'package:med_system_app/core/widgets/my_button_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final signInStore = GetIt.I.get<SignInStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (String value) {
                    signInStore.changeEmail(_emailController.text);
                  }),
              const SizedBox(height: 16.0),
              TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  onChanged: (String value) {
                    signInStore.changePassword(_passwordController.text);
                  }),
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
    );
  }
}
