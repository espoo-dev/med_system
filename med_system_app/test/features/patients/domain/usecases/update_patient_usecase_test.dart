import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:distrito_medico/features/patients/domain/usecases/update_patient_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late UpdatePatientUseCase useCase;
  late MockPatientRepository mockRepository;

  setUp(() {
    mockRepository = MockPatientRepository();
    useCase = UpdatePatientUseCase(mockRepository);
  });

  const tId = 1;
  const tName = 'Updated Patient';
  const tPatient = PatientEntity(id: tId, name: tName, deletable: true);

  group('UpdatePatientUseCase', () {
    test('deve atualizar paciente com sucesso', () async {
      // Arrange
      when(() => mockRepository.updatePatient(
            id: any(named: 'id'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => const Right(tPatient));

      // Act
      final result = await useCase(
        const UpdatePatientParams(id: tId, name: tName),
      );

      // Assert
      expect(result, const Right(tPatient));
      verify(() => mockRepository.updatePatient(id: tId, name: tName))
          .called(1);
    });

    test('deve retornar ValidationFailure quando ID for inválido', () async {
      // Act
      final result = await useCase(
        const UpdatePatientParams(id: 0, name: tName),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'ID do paciente inválido')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando nome for vazio', () async {
      // Act
      final result = await useCase(
        const UpdatePatientParams(id: tId, name: ''),
      );

      // Assert
      expect(
        result,
        const Left(
            ValidationFailure(message: 'Nome do paciente não pode ser vazio')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
