import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/core/storage/shared_preference_helper.dart';
import 'package:med_system_app/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:med_system_app/features/event_procedures/store/add_event_procedure.store.dart';
import 'package:med_system_app/features/event_procedures/store/edit_event_procedure.store.dart';
import 'package:med_system_app/features/event_procedures/store/event_procedure.store.dart';
import 'package:med_system_app/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:med_system_app/features/health_insurances/store/health_insurances.store.dart';
import 'package:med_system_app/features/hospitals/respository/hospital_repository.dart';
import 'package:med_system_app/features/hospitals/store/hospital.store.dart';
import 'package:med_system_app/features/patients/repository/patient_repository.dart';
import 'package:med_system_app/features/patients/store/patient.store.dart';
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
  getIt.registerSingleton(PatientRepository());
  getIt.registerSingleton(HospitalRepository());
  getIt.registerSingleton(HealthInsurancesRepository());
  getIt.registerSingleton(EventProcedureRepository());

  // stores
  getIt.registerLazySingleton<SignInStore>(
      () => SignInStore(getIt<SignInRepository>()));
  getIt.registerLazySingleton<ProcedureStore>(
      () => ProcedureStore(getIt<ProcedureRepository>()));
  getIt.registerLazySingleton<PatientStore>(
      () => PatientStore(getIt<PatientRepository>()));
  getIt.registerLazySingleton<HospitalStore>(
      () => HospitalStore(getIt<HospitalRepository>()));
  getIt.registerLazySingleton<HealthInsurancesStore>(
      () => HealthInsurancesStore(getIt<HealthInsurancesRepository>()));
  getIt.registerLazySingleton<EventProcedureStore>(
      () => EventProcedureStore(getIt<EventProcedureRepository>()));
  getIt.registerLazySingleton<AddEventProcedureStore>(
      () => AddEventProcedureStore(
            getIt<ProcedureRepository>(),
            getIt<PatientRepository>(),
            getIt<HospitalRepository>(),
            getIt<HealthInsurancesRepository>(),
            getIt<EventProcedureRepository>(),
          ));
  getIt.registerLazySingleton<EditEventProcedureStore>(
      () => EditEventProcedureStore(
            getIt<ProcedureRepository>(),
            getIt<PatientRepository>(),
            getIt<HospitalRepository>(),
            getIt<HealthInsurancesRepository>(),
            getIt<EventProcedureRepository>(),
          ));
}
