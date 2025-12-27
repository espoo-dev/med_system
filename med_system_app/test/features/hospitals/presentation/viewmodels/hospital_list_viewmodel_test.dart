import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/hospitals/domain/entities/hospital_entity.dart';
import 'package:distrito_medico/features/hospitals/domain/usecases/get_all_hospitals_usecase.dart';
import 'package:distrito_medico/features/hospitals/presentation/viewmodels/hospital_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllHospitalsUseCase extends Mock
    implements GetAllHospitalsUseCase {}

void main() {
  late HospitalListViewModel viewModel;
  late MockGetAllHospitalsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetAllHospitalsUseCase();
    viewModel = HospitalListViewModel(getAllHospitalsUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(const GetAllHospitalsParams());
  });

  const tHospital =
      HospitalEntity(id: 1, name: 'Test', address: 'Test Address');
  const tList = [tHospital];

  group('HospitalListViewModel', () {
    test('deve carregar hospitais com sucesso', () async {
      // Arrange
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tList));

      // Act
      await viewModel.loadHospitals(refresh: true);

      // Assert
      expect(viewModel.state, HospitalListState.success);
      expect(viewModel.hospitals, tList);
      expect(viewModel.hospitalsCount, 1);
    });

    test('deve tratar erro ao carregar hospitais', () async {
      // Arrange
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.loadHospitals(refresh: true);

      // Assert
      expect(viewModel.state, HospitalListState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
