/// Med System App - Main Entry Point
/// 
/// This is the main entry point for the Med System application.
/// Handles app initialization, dependency injection, and user session restoration.
library;

import 'package:distrito_medico/app.page.dart';
import 'package:distrito_medico/core/di/service_locator.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

/// Configures the logging system for the entire application.
/// 
/// Sets up logging to output all levels (ALL) to debug console.
/// Logs include timestamp, level, and message for debugging purposes.
void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

/// Application entry point.
/// 
/// Initialization sequence:
/// 1. Initialize Flutter bindings
/// 2. Setup logging system
/// 3. Configure dependency injection (GetIt)
/// 4. Restore user session if exists
/// 5. Launch the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  setupServiceLocator();

  final signInViewModel = GetIt.I.get<SignInViewModel>();
  await signInViewModel.loadCurrentUser();

  runApp(const AppPage());
}
