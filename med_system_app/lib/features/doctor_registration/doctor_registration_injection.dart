import 'package:distrito_medico/features/doctor_registration/data/datasources/signup_remote_datasource.dart';
import 'package:distrito_medico/features/doctor_registration/data/repositories/signup_repository_impl.dart';
import 'package:distrito_medico/features/doctor_registration/domain/repositories/signup_repository.dart';
import 'package:distrito_medico/features/doctor_registration/domain/usecases/signup_usecase.dart';
import 'package:distrito_medico/features/doctor_registration/presentation/viewmodels/signup_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupDoctorRegistrationInjection(GetIt getIt) {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(),
  );

  // ========== Repository ==========
  getIt.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(
      remoteDataSource: getIt<SignUpRemoteDataSource>(),
    ),
  );

  // ========== Use Cases ==========
  getIt.registerLazySingleton(
    () => SignUpUseCase(getIt<SignUpRepository>()),
  );

  // ========== ViewModels ==========
  getIt.registerFactory(
    () => SignUpViewModel(
      signUpUseCase: getIt<SignUpUseCase>(),
    ),
  );
}
