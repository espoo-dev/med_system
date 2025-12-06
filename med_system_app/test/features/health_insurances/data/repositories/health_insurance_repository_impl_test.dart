import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/data/datasources/health_insurance_remote_datasource.dart';
import 'package:distrito_medico/features/health_insurances/data/models/health_insurance_model.dart';
import 'package:distrito_medico/features/health_insurances/data/models/health_insurance_request_model.dart';
import 'package:distrito_medico/features/health_insurances/data/repositories/health_insurance_repository_impl.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHealthInsuranceRemoteDataSource extends Mock
    implements HealthInsuranceRemoteDataSource {}

void main() {
  late HealthInsuranceRepositoryImpl repository;
  late MockHealthInsuranceRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHealthInsuranceRemoteDataSource();
    repository = HealthInsuranceRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    registerFallbackValue(const HealthInsuranceRequestModel(name: 'dummy'));
  });

  const tHealthInsuranceModel = HealthInsuranceModel(id: 1, name: 'Unimed');
  const tHealthInsuranceEntity = HealthInsuranceEntity(id: 1, name: 'Unimed');
  final tListModels = [tHealthInsuranceModel];
  final tListEntities = [tHealthInsuranceEntity];

  group('getAllHealthInsurances', () {
    test('deve retornar lista de entidades quando datasource retorna sucesso', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAllHealthInsurances(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
            custom: any(named: 'custom'),
          )).thenAnswer((_) async => tListModels);

      // Act
      final result = await repository.getAllHealthInsurances();

      // Assert
      result.fold(
        (l) => fail('Deveria ser Right, mas foi Left: $l'),
        (r) {
          expect(r, tListEntities);
        }
      );
      verify(() => mockRemoteDataSource.getAllHealthInsurances(
            page: 1, 
            perPage: 10,
            custom: null
          )).called(1);
    });

    test('deve retornar ServerFailure quando datasource lança ServerException', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAllHealthInsurances(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
            custom: any(named: 'custom'),
          )).thenThrow(const ServerException(message: 'Erro no servidor'));

      // Act
      final result = await repository.getAllHealthInsurances();

      // Assert
      result.fold(
        (l) => expect(l, const ServerFailure(message: 'Erro no servidor')),
        (r) => fail('Deveria ser Left, mas foi Right: $r'),
      );
    });
  });

  group('createHealthInsurance', () {
    const tName = 'Unimed';

    test('deve retornar entidade criada quando sucesso', () async {
      // Arrange
      when(() => mockRemoteDataSource.createHealthInsurance(any()))
          .thenAnswer((_) async => tHealthInsuranceModel);

      // Act
      final result = await repository.createHealthInsurance(name: tName);

      // Assert
      result.fold(
        (l) => fail('Deveria ser Right, mas foi Left: $l'),
        (r) => expect(r, tHealthInsuranceEntity),
      );
    });
  });

  group('updateHealthInsurance', () {
    const tId = 1;
    const tName = 'Unimed';

    test('deve retornar entidade atualizada quando sucesso', () async {
      // Arrange
      when(() => mockRemoteDataSource.updateHealthInsurance(any(), any()))
          .thenAnswer((_) async => tHealthInsuranceModel);

      // Act
      final result = await repository.updateHealthInsurance(id: tId, name: tName);

      // Assert
      result.fold(
        (l) => fail('Deveria ser Right, mas foi Left: $l'),
        (r) => expect(r, tHealthInsuranceEntity),
      );
    });
  });
}
