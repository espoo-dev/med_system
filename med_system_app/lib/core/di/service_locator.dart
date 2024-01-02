import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/modules/signin/signin_repository.dart';
import 'package:med_system_app/core/storage/shared_preference_helper.dart';

GetIt getIt = GetIt.I;

void setupServiceLocator() {
  // async singletons:----------------------------------------------------------
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  // singletons:----------------------------------------------------------------
  getIt
      .registerSingleton(SharedPreferenceHelper(getIt<FlutterSecureStorage>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(SignInRepository(getIt<SharedPreferenceHelper>()));
}
