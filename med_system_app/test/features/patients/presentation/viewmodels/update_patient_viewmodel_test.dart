import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/update_patient_usecase.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/update_patient_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdatePatientUseCase extends Mock implements UpdatePatientUseCase {}

void main() {
  late UpdatePatientViewModel viewModel;
  late MockUpdatePatientUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUpdatePatientUseCase();
    viewModel = UpdatePatientViewModel(updatePatientUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(const UpdatePatientParams(id: 0, name: ''));
  });

  const tPatient = PatientEntity(id: 1, name: 'Test', deletable: true);

  group('UpdatePatientViewModel', () {
    test('deve atualizar paciente com sucesso', () async {
      // Arrange
      viewModel.loadPatient(tPatient);
      viewModel.setName('Updated Name');
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tPatient));

      // Act
      await viewModel.updatePatient();

      // Assert
      expect(viewModel.state, UpdatePatientState.success);
      expect(viewModel.updatedPatient, tPatient);
    });

    test('deve validar dados corretamente', () {
      viewModel.reset();
      expect(viewModel.canSubmit, false);

      viewModel.setPatientId(1);
      viewModel.setName('');
      expect(viewModel.canSubmit, false);

      viewModel.setName('Test');
      expect(viewModel.canSubmit, true);
    });

    test('deve tratar erro ao atualizar paciente', () async {
      // Arrange
      viewModel.loadPatient(tPatient);
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.updatePatient();

      // Assert
      expect(viewModel.state, UpdatePatientState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
