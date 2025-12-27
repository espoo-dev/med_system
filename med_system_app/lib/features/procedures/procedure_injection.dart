import 'package:distrito_medico/features/procedures/data/datasources/procedure_remote_datasource.dart';
import 'package:distrito_medico/features/procedures/data/repositories/procedure_repository_impl.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/create_procedure_usecase.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/update_procedure_usecase.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/create_procedure_viewmodel.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/procedure_list_viewmodel.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/update_procedure_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupProcedureInjection(GetIt getIt) {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<ProcedureRemoteDataSource>(
    () => ProcedureRemoteDataSourceImpl(),
  );

  // ========== Repository ==========
  getIt.registerLazySingleton<ProcedureRepository>(
    () => ProcedureRepositoryImpl(
      remoteDataSource: getIt<ProcedureRemoteDataSource>(),
    ),
  );

  // ========== Use Cases ==========
  getIt.registerLazySingleton(
    () => GetAllProceduresUseCase(getIt<ProcedureRepository>()),
  );

  getIt.registerLazySingleton(
    () => CreateProcedureUseCase(getIt<ProcedureRepository>()),
  );

  getIt.registerLazySingleton(
    () => UpdateProcedureUseCase(getIt<ProcedureRepository>()),
  );

  // ========== ViewModels ==========
  getIt.registerLazySingleton(
    () => ProcedureListViewModel(
      getAllProceduresUseCase: getIt<GetAllProceduresUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => CreateProcedureViewModel(
      createProcedureUseCase: getIt<CreateProcedureUseCase>(),
    ),
  );

  getIt.registerLazySingleton(
    () => UpdateProcedureViewModel(
      updateProcedureUseCase: getIt<UpdateProcedureUseCase>(),
    ),
  );
}
