import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/data/datasources/event_procedure_remote_datasource.dart';
import 'package:distrito_medico/features/event_procedures/data/models/event_procedure_model.dart';
import 'package:distrito_medico/features/event_procedures/data/repositories/event_procedure_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventProcedureRemoteDataSource extends Mock
    implements EventProcedureRemoteDataSource {}

void main() {
  late EventProcedureRepositoryImpl repository;
  late MockEventProcedureRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockEventProcedureRemoteDataSource();
    repository = EventProcedureRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getEventProcedures', () {
    const tEventProcedureModelList = [
      EventProcedureModel(id: 1, procedure: 'Consulta', patient: 'João'),
    ];
    const tEventProcedureResultModel = EventProcedureResultModel(
      items: tEventProcedureModelList,
      total: '100.00',
      totalPaid: '50.00',
      totalUnpaid: '50.00',
    );

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getEventProcedures(page: 1, perPage: 10))
          .thenAnswer((_) async => tEventProcedureResultModel);

      // act
      final result = await repository.getEventProcedures(page: 1, perPage: 10);

      // assert
      expect(result, const Right(tEventProcedureResultModel));
      verify(() => mockRemoteDataSource.getEventProcedures(page: 1, perPage: 10))
          .called(1);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getEventProcedures(page: 1, perPage: 10))
          .thenThrow(const ServerException(message: 'Server Error'));

      // act
      final result = await repository.getEventProcedures(page: 1, perPage: 10);

      // assert
      expect(result, const Left(ServerFailure(message: 'Server Error')));
      verify(() => mockRemoteDataSource.getEventProcedures(page: 1, perPage: 10))
          .called(1);
    });
  });
}
