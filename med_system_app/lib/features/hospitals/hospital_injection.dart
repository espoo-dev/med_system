import 'package:distrito_medico/features/hospitals/data/datasources/hospital_remote_datasource.dart';
import 'package:distrito_medico/features/hospitals/data/repositories/hospital_repository_impl.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/create_hospital_usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/update_hospital_usecase.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/create_hospital_viewmodel.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/hospital_list_viewmodel.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/update_hospital_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// Configura a injeção de dependências para a feature de hospitais
void setupHospitalInjection(GetIt getIt) {
  // ========== Data Sources ==========

  // Remote Data Source
  getIt.registerLazySingleton<HospitalRemoteDataSource>(
    () => HospitalRemoteDataSourceImpl(),
  );

  // ========== Repository ==========

  getIt.registerLazySingleton<HospitalRepository>(
    () => HospitalRepositoryImpl(
      remoteDataSource: getIt<HospitalRemoteDataSource>(),
    ),
  );

  // ========== Use Cases ==========

  getIt.registerLazySingleton(
    () => GetAllHospitalsUseCase(getIt<HospitalRepository>()),
  );

  getIt.registerLazySingleton(
    () => CreateHospitalUseCase(getIt<HospitalRepository>()),
  );

  getIt.registerLazySingleton(
    () => UpdateHospitalUseCase(getIt<HospitalRepository>()),
  );

  // ========== ViewModels ==========

  getIt.registerLazySingleton(
    () => HospitalListViewModel(
      getAllHospitalsUseCase: getIt<GetAllHospitalsUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => CreateHospitalViewModel(
      createHospitalUseCase: getIt<CreateHospitalUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => UpdateHospitalViewModel(
      updateHospitalUseCase: getIt<UpdateHospitalUseCase>(),
    ),
  );
}
