import 'package:distrito_medico/core/storage/shared_preference_helper.dart';
import 'package:distrito_medico/features/auth/auth_injection.dart';
import 'package:distrito_medico/features/hospitals/hospital_injection.dart';
import 'package:distrito_medico/features/patients/patient_injection.dart';
import 'package:distrito_medico/features/procedures/procedure_injection.dart';
import 'package:distrito_medico/features/forgot_passoword/forgot_password_injection.dart';
import 'package:distrito_medico/features/doctor_registration/doctor_registration_injection.dart';
import 'package:distrito_medico/features/health_insurances/health_insurance_injection.dart';
import 'package:distrito_medico/features/event_procedures/event_procedure_injection.dart';
import 'package:distrito_medico/features/medical_shifts/medical_shift_injection.dart';
import 'package:distrito_medico/features/home/home_injection.dart';
import 'package:distrito_medico/features/pdf/pdf_injection.dart';
// SignIn removido - usar Auth
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

  // ========== Repositories e Stores Legados REMOVIDOS ==========
  // Todas as features agora usam Clean Architecture com Injection própria
  

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

  // ========== Event Procedure Feature (Clean Architecture) ==========
  setupEventProcedureInjection(getIt);

  // ========== Medical Shift Feature (Clean Architecture) ==========
  setupMedicalShiftInjection(getIt);

  // ========== Home Feature (Clean Architecture) ==========
  setupHomeInjection(getIt);

  // ========== PDF Feature (Clean Architecture) ==========
  setupPdfInjection(getIt);
}
