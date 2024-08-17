import 'package:distrito_medico/core/storage/shared_preference_helper.dart';
import 'package:distrito_medico/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/store/add_event_procedure.store.dart';
import 'package:distrito_medico/features/event_procedures/store/edit_event_procedure.store.dart';
import 'package:distrito_medico/features/event_procedures/store/event_procedure.store.dart';
import 'package:distrito_medico/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:distrito_medico/features/health_insurances/store/add_health_insurances.store.dart';
import 'package:distrito_medico/features/health_insurances/store/edit_health_insurance.store.dart';
import 'package:distrito_medico/features/health_insurances/store/health_insurances.store.dart';
import 'package:distrito_medico/features/home/repository/home_repository.dart';
import 'package:distrito_medico/features/home/store/home.store.dart';
import 'package:distrito_medico/features/hospitals/respository/hospital_repository.dart';
import 'package:distrito_medico/features/hospitals/store/add_hospital.store.dart';
import 'package:distrito_medico/features/hospitals/store/edit_hospital.store.dart';
import 'package:distrito_medico/features/hospitals/store/hospital.store.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:distrito_medico/features/medical_shifts/store/add_medical_shift.store.dart';
import 'package:distrito_medico/features/medical_shifts/store/edit_medical_shift.store.dart';
import 'package:distrito_medico/features/medical_shifts/store/medical_shift.store.dart';
import 'package:distrito_medico/features/patients/repository/patient_repository.dart';
import 'package:distrito_medico/features/patients/store/add_patient.store.dart';
import 'package:distrito_medico/features/patients/store/edit_patient.store.dart';
import 'package:distrito_medico/features/patients/store/patient.store.dart';
import 'package:distrito_medico/features/procedures/repository/procedure_repository.dart';
import 'package:distrito_medico/features/procedures/store/add_procedure.store.dart';
import 'package:distrito_medico/features/procedures/store/edit_procedure.store.dart';
import 'package:distrito_medico/features/procedures/store/procedure.store.dart';
import 'package:distrito_medico/features/signin/repository/signin_repository.dart';
import 'package:distrito_medico/features/signin/store/signin.store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

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
  getIt.registerSingleton(HomeRepository());
  getIt.registerSingleton(HealthInsurancesRepository());
  getIt.registerSingleton(EventProcedureRepository());
  getIt.registerSingleton(MedicalShiftRepository());

  // stores

  getIt.registerLazySingleton<HomeStore>(
      () => HomeStore(getIt<HomeRepository>()));
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
  getIt.registerLazySingleton<AddPatientStore>(
      () => AddPatientStore(getIt<PatientRepository>()));
  getIt.registerLazySingleton<EditPatientStore>(
      () => EditPatientStore(getIt<PatientRepository>()));
  getIt.registerLazySingleton<AddHospitalStore>(
      () => AddHospitalStore(getIt<HospitalRepository>()));
  getIt.registerLazySingleton<EditHospitalStore>(
      () => EditHospitalStore(getIt<HospitalRepository>()));
  getIt.registerLazySingleton<AddProcedureStore>(
      () => AddProcedureStore(getIt<ProcedureRepository>()));
  getIt.registerLazySingleton<EditProcedureStore>(
      () => EditProcedureStore(getIt<ProcedureRepository>()));

  getIt.registerLazySingleton<AddHealthInsuranceStore>(
      () => AddHealthInsuranceStore(getIt<HealthInsurancesRepository>()));
  getIt.registerLazySingleton<EditHealthInsuranceStore>(
      () => EditHealthInsuranceStore(getIt<HealthInsurancesRepository>()));
  getIt.registerLazySingleton<AddMedicalShiftStore>(
      () => AddMedicalShiftStore(getIt<MedicalShiftRepository>()));
  getIt.registerLazySingleton<MedicalShiftStore>(
      () => MedicalShiftStore(getIt<MedicalShiftRepository>()));
  getIt.registerLazySingleton<EditMedicalShiftStore>(
      () => EditMedicalShiftStore(getIt<MedicalShiftRepository>()));
}
