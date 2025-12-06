import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/repositories/hospital_repository.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/update_hospital_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHospitalRepository extends Mock implements HospitalRepository {}

void main() {
  late UpdateHospitalUseCase useCase;
  late MockHospitalRepository mockRepository;

  setUp(() {
    mockRepository = MockHospitalRepository();
    useCase = UpdateHospitalUseCase(mockRepository);
  });

  const tId = 1;
  const tName = 'Updated Hospital';
  const tAddress = 'Updated Address';
  const tHospital = HospitalEntity(id: tId, name: tName, address: tAddress);

  group('UpdateHospitalUseCase', () {
    test('deve atualizar hospital com sucesso', () async {
      // Arrange
      when(() => mockRepository.updateHospital(
            id: any(named: 'id'),
            name: any(named: 'name'),
            address: any(named: 'address'),
          )).thenAnswer((_) async => const Right(tHospital));

      // Act
      final result = await useCase(
        const UpdateHospitalParams(id: tId, name: tName, address: tAddress),
      );

      // Assert
      expect(result, const Right(tHospital));
      verify(() => mockRepository.updateHospital(
          id: tId, name: tName, address: tAddress)).called(1);
    });

    test('deve retornar ValidationFailure quando ID for inválido', () async {
      // Act
      final result = await useCase(
        const UpdateHospitalParams(id: 0, name: tName, address: tAddress),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'ID do hospital inválido')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
