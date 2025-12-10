import 'package:get_it/get_it.dart';
import 'data/datasources/home_remote_datasource.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_latest_event_procedures_usecase.dart';
import 'domain/usecases/get_latest_medical_shifts_usecase.dart';
import 'presentation/viewmodels/home_viewmodel.dart';

/// Configura a injeção de dependências para a feature Home
void setupHomeInjection(GetIt getIt) {
  // Data Source
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetLatestEventProceduresUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLatestMedicalShiftsUseCase(getIt()));

  // ViewModels
  getIt.registerFactory(
    () => HomeViewModel(
      getIt(),
      getIt(),
    ),
  );
}
