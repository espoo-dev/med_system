import 'package:distrito_medico/features/patients/data/datasources/patient_remote_datasource.dart';
import 'package:distrito_medico/features/patients/data/repositories/patient_repository_impl.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:distrito_medico/features/patients/domain/usecases/create_patient_usecase.dart';
import 'package:distrito_medico/features/patients/domain/usecases/delete_patient_usecase.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:distrito_medico/features/patients/domain/usecases/update_patient_usecase.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/create_patient_viewmodel.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/patient_list_viewmodel.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/update_patient_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// Configura a injeção de dependências para a feature de pacientes
void setupPatientInjection(GetIt getIt) {
  // ========== Data Sources ==========

  // Remote Data Source
  getIt.registerLazySingleton<PatientRemoteDataSource>(
    () => PatientRemoteDataSourceImpl(),
  );

  // ========== Repository ==========

  getIt.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(
      remoteDataSource: getIt<PatientRemoteDataSource>(),
    ),
  );

  // ========== Use Cases ==========

  getIt.registerLazySingleton(
    () => GetAllPatientsUseCase(getIt<PatientRepository>()),
  );

  getIt.registerLazySingleton(
    () => CreatePatientUseCase(getIt<PatientRepository>()),
  );

  getIt.registerLazySingleton(
    () => UpdatePatientUseCase(getIt<PatientRepository>()),
  );

  getIt.registerLazySingleton(
    () => DeletePatientUseCase(getIt<PatientRepository>()),
  );

  // ========== ViewModels ==========

  getIt.registerLazySingleton(
    () => PatientListViewModel(
      getAllPatientsUseCase: getIt<GetAllPatientsUseCase>(),
      deletePatientUseCase: getIt<DeletePatientUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => CreatePatientViewModel(
      createPatientUseCase: getIt<CreatePatientUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => UpdatePatientViewModel(
      updatePatientUseCase: getIt<UpdatePatientUseCase>(),
    ),
  );
}
