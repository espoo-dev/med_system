import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/data/datasources/procedure_remote_datasource.dart';
import 'package:distrito_medico/features/procedures/data/models/procedure_model.dart';
import 'package:distrito_medico/features/procedures/data/repositories/procedure_repository_impl.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProcedureRemoteDataSource extends Mock
    implements ProcedureRemoteDataSource {}

void main() {
  late ProcedureRepositoryImpl repository;
  late MockProcedureRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProcedureRemoteDataSource();
    repository =
        ProcedureRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tProcedureModel = ProcedureModel(
    id: 1,
    name: 'Test',
    code: '123',
    description: 'Desc',
    amountCents: '1000',
  );
  const tProcedureEntity = ProcedureEntity(
    id: 1,
    name: 'Test',
    code: '123',
    description: 'Desc',
    amountCents: '1000',
  );
  const tListModels = [tProcedureModel];
  const tListEntities = [tProcedureEntity];

  group('ProcedureRepositoryImpl', () {
    group('getAllProcedures', () {
      test('deve retornar lista de entidades quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.getAllProcedures(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
            )).thenAnswer((_) async => tListModels);

        // Act
        final result = await repository.getAllProcedures();

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
        when(() => mockRemoteDataSource.getAllProcedures(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
            )).thenThrow(const ServerException(message: 'Erro'));

        // Act
        final result = await repository.getAllProcedures();

        // Assert
        expect(result, const Left(ServerFailure(message: 'Erro')));
      });
    });

    group('createProcedure', () {
      test('deve retornar entidade criada quando sucesso', () async {
        // Arrange
        when(() => mockRemoteDataSource.createProcedure(
              name: any(named: 'name'),
              code: any(named: 'code'),
              description: any(named: 'description'),
              amountCents: any(named: 'amountCents'),
            )).thenAnswer((_) async => tProcedureModel);

        // Act
        final result = await repository.createProcedure(
          name: 'Test',
          code: '123',
          description: 'Desc',
          amountCents: '1000',
        );

        // Assert
        expect(result, const Right(tProcedureEntity));
      });
    });
  });
}
