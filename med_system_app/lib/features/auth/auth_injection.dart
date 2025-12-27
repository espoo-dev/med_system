import 'package:distrito_medico/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:distrito_medico/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:distrito_medico/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:distrito_medico/features/auth/domain/repositories/auth_repository.dart';
import 'package:distrito_medico/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:distrito_medico/features/auth/domain/usecases/logout_usecase.dart';
import 'package:distrito_medico/features/auth/domain/usecases/signin_usecase.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

/// Configura a injeção de dependências para a feature de autenticação
void setupAuthInjection(GetIt getIt) {
  // ========== Data Sources ==========
  
  // Local Data Source
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      secureStorage: getIt<FlutterSecureStorage>(),
    ),
  );

  // Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // ========== Repository ==========
  
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // ========== Use Cases ==========
  
  getIt.registerLazySingleton(
    () => SignInUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );

  // ========== ViewModel ==========
  
  getIt.registerLazySingleton(
    () => SignInViewModel(
      signInUseCase: getIt<SignInUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
    ),
  );
}
