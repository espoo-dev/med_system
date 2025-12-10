import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/data/models/event_procedure_list_model.dart';
import 'package:distrito_medico/features/event_procedures/data/models/event_procedure_model.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';
import 'package:distrito_medico/features/home/data/datasources/home_remote_datasource.dart';
import 'package:distrito_medico/features/home/data/repositories/home_repository_impl.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_list_model.dart';
import 'package:distrito_medico/features/medical_shifts/data/models/medical_shift_model.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getLatestEventProcedures', () {
    const tPage = 1;
    const tPerPage = 3;

    final tEventProcedureModels = [
      const EventProcedureModel(
        id: 1,
        patient: 'João Silva',
        procedure: 'Consulta',
        hospital: 'Hospital ABC',
        totalAmountCents: '15000',
        paid: false,
      ),
    ];

      final tEventProcedureListModel = EventProcedureListModel(items: tEventProcedureModels);
      final tEventProcedureListEntity = EventProcedureListModel(items: tEventProcedureModels); // Model is an Entity

      test('should return list of EventProcedureEntity when call is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getLatestEventProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => tEventProcedureListModel);

      // act
      final result = await repository.getLatestEventProcedures(
        page: tPage,
        perPage: tPerPage,
      );

      // assert
      expect(result, Right(tEventProcedureListEntity));
      verify(() => mockRemoteDataSource.getLatestEventProcedures(
            page: tPage,
            perPage: tPerPage,
          )).called(1);
    });

    test('should return ServerFailure when datasource throws ServerException',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getLatestEventProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenThrow(const ServerException(message: 'Server error'));

      // act
      final result = await repository.getLatestEventProcedures(
        page: tPage,
        perPage: tPerPage,
      );

      // assert
      expect(result, const Left(ServerFailure(message: 'Server error')));
    });
  });

  group('getLatestMedicalShifts', () {
    const tPage = 1;
    const tPerPage = 3;

    final tMedicalShiftModels = [
      const MedicalShiftModel(
        id: 1,
        hospitalName: 'Hospital ABC',
        workload: '12',
        startDate: '2025-12-10',
        startHour: '08:00',
        amountCents: '50000',
        paid: false,
        shift: 'Daytime',
      ),
    ];

      final tMedicalShiftListModel = MedicalShiftListModel(items: tMedicalShiftModels);
      final tMedicalShiftListEntity = MedicalShiftListModel(items: tMedicalShiftModels);

      test('should return list of MedicalShiftEntity when call is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getLatestMedicalShifts(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => tMedicalShiftListModel);

      // act
      final result = await repository.getLatestMedicalShifts(
        page: tPage,
        perPage: tPerPage,
      );

      // assert
      expect(result, Right(tMedicalShiftListEntity));
      verify(() => mockRemoteDataSource.getLatestMedicalShifts(
            page: tPage,
            perPage: tPerPage,
          )).called(1);
    });

    test('should return ServerFailure when datasource throws ServerException',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getLatestMedicalShifts(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenThrow(const ServerException(message: 'Server error'));

      // act
      final result = await repository.getLatestMedicalShifts(
        page: tPage,
        perPage: tPerPage,
      );

      // assert
      expect(result, const Left(ServerFailure(message: 'Server error')));
    });
  });
}
