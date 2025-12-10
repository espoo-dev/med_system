import 'package:distrito_medico/features/medical_shifts/data/datasources/medical_shift_remote_datasource.dart';
import 'package:distrito_medico/features/medical_shifts/data/repositories/medical_shift_repository_impl.dart';
import 'package:distrito_medico/features/medical_shifts/domain/repositories/medical_shift_repository.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/create_medical_shift_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/create_medical_shift_recurrence_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/delete_medical_shift_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/generate_pdf_report_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_amount_suggestions_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_hospital_suggestions_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/get_medical_shifts_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/update_medical_shift_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/usecases/update_payment_status_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/create_medical_shift_viewmodel.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/medical_shifts_list_viewmodel.dart';
import 'package:distrito_medico/features/medical_shifts/presentation/viewmodels/update_medical_shift_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupMedicalShiftInjection(GetIt getIt) {
  // Datasource
  getIt.registerLazySingleton<IMedicalShiftRemoteDataSource>(
    () => MedicalShiftRemoteDataSource(),
  );

  // Repository
  getIt.registerLazySingleton<IMedicalShiftRepository>(
    () => MedicalShiftRepositoryImpl(getIt<IMedicalShiftRemoteDataSource>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetMedicalShiftsUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => CreateMedicalShiftUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => CreateMedicalShiftRecurrenceUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => UpdateMedicalShiftUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => DeleteMedicalShiftUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => UpdatePaymentStatusUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => GetHospitalSuggestionsUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => GetAmountSuggestionsUseCase(getIt<IMedicalShiftRepository>()));
  getIt.registerLazySingleton(() => GeneratePdfReportUseCase(getIt<IMedicalShiftRepository>()));

  // ViewModels
  getIt.registerLazySingleton(() => MedicalShiftsListViewModel(
    getMedicalShiftsUseCase: getIt(),
    deleteMedicalShiftUseCase: getIt(),
    updatePaymentStatusUseCase: getIt(),
    generatePdfReportUseCase: getIt(),
  ));
  
  getIt.registerLazySingleton(() => CreateMedicalShiftViewModel(
    createMedicalShiftUseCase: getIt(),
    createMedicalShiftRecurrenceUseCase: getIt(),
    getHospitalSuggestionsUseCase: getIt(),
    getAmountSuggestionsUseCase: getIt(),
  ));

  getIt.registerLazySingleton(() => UpdateMedicalShiftViewModel(
    updateMedicalShiftUseCase: getIt(),
    getHospitalSuggestionsUseCase: getIt(),
    getAmountSuggestionsUseCase: getIt(),
  ));
}
