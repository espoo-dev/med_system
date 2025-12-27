import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/create_hospital_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHospitalRepository extends Mock implements HospitalRepository {}

void main() {
  late CreateHospitalUseCase useCase;
  late MockHospitalRepository mockRepository;

  setUp(() {
    mockRepository = MockHospitalRepository();
    useCase = CreateHospitalUseCase(mockRepository);
  });

  const tName = 'New Hospital';
  const tAddress = 'New Address';
  const tHospital = HospitalEntity(id: 1, name: tName, address: tAddress);

  group('CreateHospitalUseCase', () {
    test('deve criar hospital com sucesso', () async {
      // Arrange
      when(() => mockRepository.createHospital(
            name: any(named: 'name'),
            address: any(named: 'address'),
          )).thenAnswer((_) async => const Right(tHospital));

      // Act
      final result = await useCase(
        const CreateHospitalParams(name: tName, address: tAddress),
      );

      // Assert
      expect(result, const Right(tHospital));
      verify(() => mockRepository.createHospital(name: tName, address: tAddress))
          .called(1);
    });

    test('deve retornar ValidationFailure quando nome for vazio', () async {
      // Act
      final result = await useCase(
        const CreateHospitalParams(name: '', address: tAddress),
      );

      // Assert
      expect(
        result,
        const Left(
            ValidationFailure(message: 'Nome do hospital não pode ser vazio')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando endereço for vazio', () async {
      // Act
      final result = await useCase(
        const CreateHospitalParams(name: tName, address: ''),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(
            message: 'Endereço do hospital não pode ser vazio')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
