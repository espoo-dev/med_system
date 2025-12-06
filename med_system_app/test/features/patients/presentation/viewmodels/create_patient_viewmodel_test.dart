import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/create_patient_usecase.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/create_patient_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePatientUseCase extends Mock implements CreatePatientUseCase {}

void main() {
  late CreatePatientViewModel viewModel;
  late MockCreatePatientUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockCreatePatientUseCase();
    viewModel = CreatePatientViewModel(createPatientUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(const CreatePatientParams(name: ''));
  });

  const tPatient = PatientEntity(id: 1, name: 'Test', deletable: true);

  group('CreatePatientViewModel', () {
    test('deve criar paciente com sucesso', () async {
      // Arrange
      viewModel.setName('Test');
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tPatient));

      // Act
      await viewModel.createPatient();

      // Assert
      expect(viewModel.state, CreatePatientState.success);
      expect(viewModel.createdPatient, tPatient);
    });

    test('deve validar nome corretamente', () {
      viewModel.setName('');
      expect(viewModel.canSubmit, false);
      expect(viewModel.isValidName, false);

      viewModel.setName('Ab');
      expect(viewModel.canSubmit, true);
      expect(viewModel.isValidName, false);

      viewModel.setName('Abc');
      expect(viewModel.canSubmit, true);
      expect(viewModel.isValidName, true);
    });

    test('deve tratar erro ao criar paciente', () async {
      // Arrange
      viewModel.setName('Test');
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.createPatient();

      // Assert
      expect(viewModel.state, CreatePatientState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
