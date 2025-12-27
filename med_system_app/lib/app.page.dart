import 'package:distrito_medico/core/pages/splash/splash_page.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  modePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    modePortrait();

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Nunito',
        useMaterial3: true,
      ),
      home: const Template(),
    );
  }
}

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  final signInViewModel = GetIt.I.get<SignInViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(
      autorun(
        (_) {
          if (!signInViewModel.isAuthenticated) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => signInViewModel.isAuthenticated
            ? const HomePage()
            : const SplashScreenPage());
  }
}
