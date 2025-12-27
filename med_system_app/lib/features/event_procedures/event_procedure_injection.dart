import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'presentation/viewmodels/create_event_procedure_viewmodel.dart';
import 'presentation/viewmodels/update_event_procedure_viewmodel.dart';
import 'presentation/viewmodels/filter_event_procedures_viewmodel.dart';
import 'domain/usecases/generate_event_procedure_pdf_usecase.dart';
import 'package:get_it/get_it.dart';
import '../../core/api/api.dart'; // To access eventProcedureService
import 'data/datasources/event_procedure_remote_datasource.dart';
import 'data/repositories/event_procedure_repository_impl.dart';
import 'domain/repositories/event_procedure_repository.dart';
import 'domain/usecases/create_event_procedure_usecase.dart';
import 'domain/usecases/delete_event_procedure_usecase.dart';
import 'domain/usecases/get_event_procedures_usecase.dart';
import 'domain/usecases/update_event_procedure_payment_usecase.dart';
import 'domain/usecases/update_event_procedure_usecase.dart';
import 'presentation/viewmodels/event_procedures_list_viewmodel.dart';

void setupEventProcedureInjection(GetIt getIt) {
  // Data Source
  getIt.registerLazySingleton<EventProcedureRemoteDataSource>(
    () => EventProcedureRemoteDataSourceImpl(eventProcedureService),
  );

  // Repository
  getIt.registerLazySingleton<EventProcedureRepository>(
    () => EventProcedureRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetEventProceduresUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateEventProcedureUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateEventProcedureUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteEventProcedureUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateEventProcedurePaymentUseCase(getIt()));

  // ViewModels
  getIt.registerFactory(() => EventProceduresListViewModel(
        getIt(), 
        getIt(), 
        getIt(),
        getIt(), // GenerateEventProcedurePdfUseCase
      ));

  getIt.registerFactory(() => CreateEventProcedureViewModel(
        getIt(),
        getIt<GetAllHospitalsUseCase>(),
        getIt<GetAllPatientsUseCase>(),
        getIt<GetAllProceduresUseCase>(),
        getIt<GetAllHealthInsurancesUseCase>(),
      ));

  getIt.registerLazySingleton<GenerateEventProcedurePdfUseCase>(
      () => GenerateEventProcedurePdfUseCase(getIt()));

  getIt.registerFactory(() => UpdateEventProcedureViewModel(
        getIt(),
        getIt<GetAllHospitalsUseCase>(),
        getIt<GetAllPatientsUseCase>(),
        getIt<GetAllProceduresUseCase>(),
        getIt<GetAllHealthInsurancesUseCase>(),
      ));

  getIt.registerFactory(() => FilterEventProceduresViewModel(
        getIt<GetAllHospitalsUseCase>(),
        getIt<GetAllHealthInsurancesUseCase>(),
      ));
}
