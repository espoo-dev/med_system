import 'package:distrito_medico/app.page.dart';
import 'package:distrito_medico/core/di/service_locator.dart';
import 'package:distrito_medico/features/signin/store/signin.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  setupServiceLocator();

  final signStore = GetIt.I.get<SignInStore>();
  await signStore.getUserStorage();

  runApp(const AppPage());
}
