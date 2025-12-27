import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/generate_event_procedure_pdf_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'generate_event_procedure_pdf_usecase_test.mocks.dart';

@GenerateMocks([EventProcedureRepository])
void main() {
  late GenerateEventProcedurePdfUseCase useCase;
  late MockEventProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockEventProcedureRepository();
    useCase = GenerateEventProcedurePdfUseCase(mockRepository);
  });

  const tFilters = GenerateEventProcedurePdfParams(
    month: 1,
    year: 2023,
  );

  final tUint8List = Uint8List.fromList([1, 2, 3]);

  test(
    'should get PDF data (Uint8List) from the repository',
    () async {
      // arrange
      when(mockRepository.generatePdfReport(
        month: anyNamed('month'),
        year: anyNamed('year'),
      )).thenAnswer((_) async => Right(tUint8List));

      // act
      final result = await useCase(tFilters);

      // assert
      expect(result, Right(tUint8List));
      verify(mockRepository.generatePdfReport(
        month: tFilters.month,
        year: tFilters.year,
        paid: null,
        healthInsuranceName: null,
        hospitalName: null,
      ));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
