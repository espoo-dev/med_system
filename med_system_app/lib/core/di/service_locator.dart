import 'package:distrito_medico/core/storage/shared_preference_helper.dart';
import 'package:distrito_medico/features/auth/auth_injection.dart';
import 'package:distrito_medico/features/doctor_registration/repository/signup_repository.dart';
import 'package:distrito_medico/features/doctor_registration/store/signup.store.dart';
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
import 'package:distrito_medico/features/hospitals/hospital_injection.dart';
import 'package:distrito_medico/features/hospitals/respository/hospital_repository.dart';
import 'package:distrito_medico/features/medical_shifts/repository/medical_shift_repository.dart';
import 'package:distrito_medico/features/medical_shifts/store/add_medical_shift.store.dart';
import 'package:distrito_medico/features/medical_shifts/store/edit_medical_shift.store.dart';
import 'package:distrito_medico/features/medical_shifts/store/medical_shift.store.dart';
import 'package:distrito_medico/features/patients/patient_injection.dart';
import 'package:distrito_medico/features/patients/repository/patient_repository.dart';
import 'package:distrito_medico/features/pdf/store/pdf_viewer.store.dart';
import 'package:distrito_medico/features/procedures/procedure_injection.dart';
import 'package:distrito_medico/features/procedures/repository/procedure_repository.dart';
import 'package:distrito_medico/features/forgot_passoword/forgot_password_injection.dart';
import 'package:distrito_medico/features/doctor_registration/doctor_registration_injection.dart';
import 'package:distrito_medico/features/health_insurances/health_insurance_injection.dart';
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
  
  // Mantidos para compatibilidade com outras features ainda não migradas
  getIt.registerSingleton(ProcedureRepository());
  getIt.registerSingleton(PatientRepository());
  getIt.registerSingleton(HospitalRepository());
  
  getIt.registerSingleton(HomeRepository());
  getIt.registerSingleton(HealthInsurancesRepository());
  getIt.registerSingleton(EventProcedureRepository());
  getIt.registerSingleton(MedicalShiftRepository());
  getIt.registerSingleton(SignUpRepository());

  // stores

  getIt.registerLazySingleton<HomeStore>(
      () => HomeStore(getIt<HomeRepository>()));
  getIt.registerLazySingleton<SignInStore>(
      () => SignInStore(getIt<SignInRepository>()));
  
  // Stores antigas comentadas pois foram migradas para Clean Architecture
  // getIt.registerLazySingleton<ProcedureStore>(
  //     () => ProcedureStore(getIt<ProcedureRepository>()));
  
  // getIt.registerLazySingleton<PatientStore>(
  //     () => PatientStore(getIt<PatientRepository>()));
  
  // getIt.registerLazySingleton<HospitalStore>(
  //     () => HospitalStore(getIt<HospitalRepository>()));
  
  // getIt.registerLazySingleton<HealthInsurancesStore>(
  //     () => HealthInsurancesStore(getIt<HealthInsurancesRepository>()));
      
  getIt.registerLazySingleton<EventProcedureStore>(() => EventProcedureStore(
      getIt<EventProcedureRepository>(),
      getIt<HospitalRepository>(),
      getIt<HealthInsurancesRepository>()));
      
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
          
  // Stores antigas comentadas
  // getIt.registerLazySingleton<AddPatientStore>(
  //     () => AddPatientStore(getIt<PatientRepository>()));
  // getIt.registerLazySingleton<EditPatientStore>(
  //     () => EditPatientStore(getIt<PatientRepository>()));
      
  // getIt.registerLazySingleton<AddHospitalStore>(
  //     () => AddHospitalStore(getIt<HospitalRepository>()));
  // getIt.registerLazySingleton<EditHospitalStore>(
  //     () => EditHospitalStore(getIt<HospitalRepository>()));

  // getIt.registerLazySingleton<AddProcedureStore>(
  //     () => AddProcedureStore(getIt<ProcedureRepository>()));
  // getIt.registerLazySingleton<EditProcedureStore>(
  //     () => EditProcedureStore(getIt<ProcedureRepository>()));

  // getIt.registerLazySingleton<AddHealthInsuranceStore>(
  //     () => AddHealthInsuranceStore(getIt<HealthInsurancesRepository>()));
  // getIt.registerLazySingleton<EditHealthInsuranceStore>(
  //     () => EditHealthInsuranceStore(getIt<HealthInsurancesRepository>()));
      
  getIt.registerLazySingleton<AddMedicalShiftStore>(
      () => AddMedicalShiftStore(getIt<MedicalShiftRepository>()));
      
  getIt.registerLazySingleton<MedicalShiftStore>(() => MedicalShiftStore(
        getIt<MedicalShiftRepository>(),
      ));
      
  getIt.registerLazySingleton<EditMedicalShiftStore>(
      () => EditMedicalShiftStore(getIt<MedicalShiftRepository>()));

  getIt.registerLazySingleton<PdfViewerStore>(() => PdfViewerStore());

  getIt.registerLazySingleton<SignUpStore>(
      () => SignUpStore(getIt<SignUpRepository>()));

  // ========== Auth Feature (Clean Architecture) ==========
  setupAuthInjection(getIt);

  // ========== Patient Feature (Clean Architecture) ==========
  setupPatientInjection(getIt);

  // ========== Hospital Feature (Clean Architecture) ==========
  setupHospitalInjection(getIt);

  // ========== Procedure Feature (Clean Architecture) ==========
  setupProcedureInjection(getIt);

  // ========== Forgot Password Feature (Clean Architecture) ==========
  setupForgotPasswordInjection(getIt);

  // ========== Doctor Registration Feature (Clean Architecture) ==========
  setupDoctorRegistrationInjection(getIt);

  // ========== Health Insurance Feature (Clean Architecture) ==========
  setupHealthInsuranceInjection(getIt);
}
