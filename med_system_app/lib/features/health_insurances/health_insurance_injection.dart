import 'package:distrito_medico/features/health_insurances/data/datasources/health_insurance_remote_datasource.dart';
import 'package:distrito_medico/features/health_insurances/data/repositories/health_insurance_repository_impl.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/create_health_insurance_usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/update_health_insurance_usecase.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/create_health_insurance_viewmodel.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/health_insurance_list_viewmodel.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/update_health_insurance_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupHealthInsuranceInjection(GetIt getIt) {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<HealthInsuranceRemoteDataSource>(
    () => HealthInsuranceRemoteDataSourceImpl(),
  );

  // ========== Repository ==========
  getIt.registerLazySingleton<HealthInsuranceRepository>(
    () => HealthInsuranceRepositoryImpl(
      remoteDataSource: getIt<HealthInsuranceRemoteDataSource>(),
    ),
  );

  // ========== Use Cases ==========
  getIt.registerLazySingleton(
    () => GetAllHealthInsurancesUseCase(getIt<HealthInsuranceRepository>()),
  );
  getIt.registerLazySingleton(
    () => CreateHealthInsuranceUseCase(getIt<HealthInsuranceRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateHealthInsuranceUseCase(getIt<HealthInsuranceRepository>()),
  );

  // ========== ViewModels ==========
  getIt.registerFactory(
    () => HealthInsuranceListViewModel(
      getAllHealthInsurancesUseCase: getIt<GetAllHealthInsurancesUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => CreateHealthInsuranceViewModel(
      createHealthInsuranceUseCase: getIt<CreateHealthInsuranceUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => UpdateHealthInsuranceViewModel(
      updateHealthInsuranceUseCase: getIt<UpdateHealthInsuranceUseCase>(),
    ),
  );
}
