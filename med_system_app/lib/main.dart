import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:med_system_app/app.page.dart';
import 'package:med_system_app/core/di/service_locator.dart';

import 'package:med_system_app/features/signin/store/signin.store.dart';

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
