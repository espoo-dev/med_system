import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:distrito_medico/features/patients/domain/usecases/delete_patient_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late DeletePatientUseCase useCase;
  late MockPatientRepository mockRepository;

  setUp(() {
    mockRepository = MockPatientRepository();
    useCase = DeletePatientUseCase(mockRepository);
  });

  const tId = 1;

  group('DeletePatientUseCase', () {
    test('deve deletar paciente com sucesso', () async {
      // Arrange
      when(() => mockRepository.deletePatient(id: any(named: 'id')))
          .thenAnswer((_) async => const Right(unit));

      // Act
      final result = await useCase(const DeletePatientParams(id: tId));

      // Assert
      expect(result, const Right(unit));
      verify(() => mockRepository.deletePatient(id: tId)).called(1);
    });

    test('deve retornar ValidationFailure quando ID for inválido', () async {
      // Act
      final result = await useCase(const DeletePatientParams(id: 0));

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'ID do paciente inválido')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
