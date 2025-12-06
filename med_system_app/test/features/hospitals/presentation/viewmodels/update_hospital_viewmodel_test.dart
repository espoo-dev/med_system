import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/update_hospital_usecase.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/update_hospital_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateHospitalUseCase extends Mock implements UpdateHospitalUseCase {}

void main() {
  late UpdateHospitalViewModel viewModel;
  late MockUpdateHospitalUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUpdateHospitalUseCase();
    viewModel = UpdateHospitalViewModel(updateHospitalUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(
        const UpdateHospitalParams(id: 0, name: '', address: ''));
  });

  const tHospital =
      HospitalEntity(id: 1, name: 'Test', address: 'Test Address');

  group('UpdateHospitalViewModel', () {
    test('deve atualizar hospital com sucesso', () async {
      // Arrange
      viewModel.loadHospital(tHospital);
      viewModel.setName('Updated Name');
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tHospital));

      // Act
      await viewModel.updateHospital();

      // Assert
      expect(viewModel.state, UpdateHospitalState.success);
      expect(viewModel.updatedHospital, tHospital);
    });

    test('deve validar dados corretamente', () {
      viewModel.reset();
      expect(viewModel.canSubmit, false);

      viewModel.setHospitalId(1);
      viewModel.setName('Test');
      viewModel.setAddress('Address');
      expect(viewModel.canSubmit, true);
    });

    test('deve tratar erro ao atualizar hospital', () async {
      // Arrange
      viewModel.loadHospital(tHospital);
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.updateHospital();

      // Assert
      expect(viewModel.state, UpdateHospitalState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
