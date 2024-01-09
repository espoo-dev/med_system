import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/storage/shared_preference_helper.dart';
import 'package:med_system_app/features/procedures/repository/procedure_repository.dart';
import 'package:med_system_app/features/procedures/store/procedure.store.dart';
import 'package:med_system_app/features/signin/repository/signin_repository.dart';
import 'package:med_system_app/features/signin/store/signin.store.dart';

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
  getIt.registerSingleton(ProcedureRepository());

  // stores
  getIt.registerLazySingleton<SignInStore>(
      () => SignInStore(getIt<SignInRepository>()));
  getIt.registerLazySingleton<ProcedureStore>(
      () => ProcedureStore(getIt<ProcedureRepository>()));
}
