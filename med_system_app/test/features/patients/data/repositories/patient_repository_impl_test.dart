import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/data/datasources/patient_remote_datasource.dart';
import 'package:distrito_medico/features/patients/data/models/patient_model.dart';
import 'package:distrito_medico/features/patients/data/repositories/patient_repository_impl.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientRemoteDataSource extends Mock
    implements PatientRemoteDataSource {}

void main() {
  late PatientRepositoryImpl repository;
  late MockPatientRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPatientRemoteDataSource();
    repository = PatientRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tPatientModel = PatientModel(id: 1, name: 'Test', deletable: true);
  const tPatientEntity = PatientEntity(id: 1, name: 'Test', deletable: true);
  const tListModels = [tPatientModel];
  const tListEntities = [tPatientEntity];

  group('PatientRepositoryImpl', () {
    group('getAllPatients', () {
      test('deve retornar lista de entidades quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.getAllPatients(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
            )).thenAnswer((_) async => tListModels);

        // Act
        final result = await repository.getAllPatients();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should return Right'),
          (list) {
            expect(list.length, tListEntities.length);
            expect(list, tListEntities);
          },
        );
        verify(() => mockRemoteDataSource.getAllPatients(page: 1, perPage: 10000))
            .called(1);
      });

      test('deve retornar ServerFailure quando datasource lançar ServerException',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.getAllPatients(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
            )).thenThrow(const ServerException(message: 'Erro'));

        // Act
        final result = await repository.getAllPatients();

        // Assert
        expect(result, const Left(ServerFailure(message: 'Erro')));
      });
    });

    group('createPatient', () {
      test('deve retornar entidade criada quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.createPatient(name: any(named: 'name')))
            .thenAnswer((_) async => tPatientModel);

        // Act
        final result = await repository.createPatient(name: 'Test');

        // Assert
        expect(result, const Right(tPatientEntity));
      });
    });

    group('updatePatient', () {
      test('deve retornar entidade atualizada quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.updatePatient(
              id: any(named: 'id'),
              name: any(named: 'name'),
            )).thenAnswer((_) async => tPatientModel);

        // Act
        final result = await repository.updatePatient(id: 1, name: 'Test');

        // Assert
        expect(result, const Right(tPatientEntity));
      });
    });

    group('deletePatient', () {
      test('deve retornar Unit quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.deletePatient(id: any(named: 'id')))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.deletePatient(id: 1);

        // Assert
        expect(result, const Right(unit));
      });
    });
  });
}
