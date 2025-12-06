import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHospitalRepository extends Mock implements HospitalRepository {}

void main() {
  late GetAllHospitalsUseCase useCase;
  late MockHospitalRepository mockRepository;

  setUp(() {
    mockRepository = MockHospitalRepository();
    useCase = GetAllHospitalsUseCase(mockRepository);
  });

  const tHospitalList = [
    HospitalEntity(id: 1, name: 'Hospital 1', address: 'Address 1'),
    HospitalEntity(id: 2, name: 'Hospital 2', address: 'Address 2'),
  ];

  group('GetAllHospitalsUseCase', () {
    test('deve retornar lista de hospitais quando sucesso', () async {
      // Arrange
      when(() => mockRepository.getAllHospitals(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => const Right(tHospitalList));

      // Act
      final result = await useCase(const GetAllHospitalsParams());

      // Assert
      expect(result, const Right(tHospitalList));
      verify(() => mockRepository.getAllHospitals(page: 1, perPage: 10000))
          .called(1);
    });

    test('deve retornar ValidationFailure quando página for inválida', () async {
      // Act
      final result = await useCase(
        const GetAllHospitalsParams(page: 0),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'Página deve ser maior que 0')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ServerFailure quando repositório falhar', () async {
      // Arrange
      when(() => mockRepository.getAllHospitals(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro no servidor')),
      );

      // Act
      final result = await useCase(const GetAllHospitalsParams());

      // Assert
      expect(
        result,
        const Left(ServerFailure(message: 'Erro no servidor')),
      );
    });
  });
}
