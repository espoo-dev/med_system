import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/create_hospital_usecase.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/create_hospital_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateHospitalUseCase extends Mock implements CreateHospitalUseCase {}

void main() {
  late CreateHospitalViewModel viewModel;
  late MockCreateHospitalUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockCreateHospitalUseCase();
    viewModel = CreateHospitalViewModel(createHospitalUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(
        const CreateHospitalParams(name: '', address: ''));
  });

  const tHospital =
      HospitalEntity(id: 1, name: 'Test', address: 'Test Address');

  group('CreateHospitalViewModel', () {
    test('deve criar hospital com sucesso', () async {
      // Arrange
      viewModel.setName('Test');
      viewModel.setAddress('Test Address');
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tHospital));

      // Act
      await viewModel.createHospital();

      // Assert
      expect(viewModel.state, CreateHospitalState.success);
      expect(viewModel.createdHospital, tHospital);
    });

    test('deve validar dados corretamente', () {
      viewModel.setName('');
      viewModel.setAddress('');
      expect(viewModel.canSubmit, false);

      viewModel.setName('Te');
      expect(viewModel.isValidName, false);

      viewModel.setName('Test');
      expect(viewModel.isValidName, true);

      viewModel.setAddress('Addr');
      expect(viewModel.isValidAddress, false);

      viewModel.setAddress('Address');
      expect(viewModel.isValidAddress, true);
    });

    test('deve tratar erro ao criar hospital', () async {
      // Arrange
      viewModel.setName('Test');
      viewModel.setAddress('Test Address');
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.createHospital();

      // Assert
      expect(viewModel.state, CreateHospitalState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
