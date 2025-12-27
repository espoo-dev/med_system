import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/data/datasources/hospital_remote_datasource.dart';
import 'package:distrito_medico/features/hospitals/data/models/hospital_model.dart';
import 'package:distrito_medico/features/hospitals/data/repositories/hospital_repository_impl.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHospitalRemoteDataSource extends Mock
    implements HospitalRemoteDataSource {}

void main() {
  late HospitalRepositoryImpl repository;
  late MockHospitalRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHospitalRemoteDataSource();
    repository = HospitalRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tHospitalModel =
      HospitalModel(id: 1, name: 'Test', address: 'Test Address');
  const tHospitalEntity =
      HospitalEntity(id: 1, name: 'Test', address: 'Test Address');
  const tListModels = [tHospitalModel];
  const tListEntities = [tHospitalEntity];

  group('HospitalRepositoryImpl', () {
    group('getAllHospitals', () {
      test('deve retornar lista de entidades quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.getAllHospitals(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
            )).thenAnswer((_) async => tListModels);

        // Act
        final result = await repository.getAllHospitals();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should return Right'),
          (list) {
            expect(list.length, tListEntities.length);
            expect(list, tListEntities);
          },
        );
      });

      test(
          'deve retornar ServerFailure quando datasource lançar ServerException',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.getAllHospitals(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
            )).thenThrow(const ServerException(message: 'Erro'));

        // Act
        final result = await repository.getAllHospitals();

        // Assert
        expect(result, const Left(ServerFailure(message: 'Erro')));
      });
    });

    group('createHospital', () {
      test('deve retornar entidade criada quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.createHospital(
              name: any(named: 'name'),
              address: any(named: 'address'),
            )).thenAnswer((_) async => tHospitalModel);

        // Act
        final result = await repository.createHospital(
            name: 'Test', address: 'Test Address');

        // Assert
        expect(result, const Right(tHospitalEntity));
      });
    });

    group('updateHospital', () {
      test('deve retornar entidade atualizada quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.updateHospital(
              id: any(named: 'id'),
              name: any(named: 'name'),
              address: any(named: 'address'),
            )).thenAnswer((_) async => tHospitalModel);

        // Act
        final result = await repository.updateHospital(
            id: 1, name: 'Test', address: 'Test Address');

        // Assert
        expect(result, const Right(tHospitalEntity));
      });
    });
  });
}
