import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/update_event_procedure_payment_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventProcedureRepository extends Mock
    implements EventProcedureRepository {}

void main() {
  late UpdateEventProcedurePaymentUseCase usecase;
  late MockEventProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockEventProcedureRepository();
    usecase = UpdateEventProcedurePaymentUseCase(mockRepository);
  });

  const tParams = UpdateEventProcedurePaymentParams(
    id: 1,
    paid: true,
    paidAt: '2025-12-10',
    payment: 'PIX',
  );

  const tEventProcedure = EventProcedureEntity(
    id: 1,
    patient: 'João Silva',
    procedure: 'Consulta',
    hospital: 'Hospital ABC',
    paid: true,
    paidAt: '2025-12-10',
    payment: 'PIX',
  );

  test('should update payment status from repository', () async {
    // arrange
    when(() => mockRepository.updatePaymentStatus(
          id: any(named: 'id'),
          paid: any(named: 'paid'),
          paidAt: any(named: 'paidAt'),
          payment: any(named: 'payment'),
        )).thenAnswer((_) async => const Right(tEventProcedure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Right(tEventProcedure));
    verify(() => mockRepository.updatePaymentStatus(
          id: tParams.id,
          paid: tParams.paid,
          paidAt: tParams.paidAt,
          payment: tParams.payment,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Payment update failed');
    when(() => mockRepository.updatePaymentStatus(
          id: any(named: 'id'),
          paid: any(named: 'paid'),
          paidAt: any(named: 'paidAt'),
          payment: any(named: 'payment'),
        )).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.updatePaymentStatus(
          id: tParams.id,
          paid: tParams.paid,
          paidAt: tParams.paidAt,
          payment: tParams.payment,
        )).called(1);
  });

  test('should handle unpaid status', () async {
    // arrange
    const tUnpaidParams = UpdateEventProcedurePaymentParams(
      id: 2,
      paid: false,
    );

    const tUnpaidProcedure = EventProcedureEntity(
      id: 2,
      patient: 'Maria Santos',
      procedure: 'Exame',
      hospital: 'Hospital XYZ',
      paid: false,
    );

    when(() => mockRepository.updatePaymentStatus(
          id: any(named: 'id'),
          paid: any(named: 'paid'),
          paidAt: any(named: 'paidAt'),
          payment: any(named: 'payment'),
        )).thenAnswer((_) async => const Right(tUnpaidProcedure));

    // act
    final result = await usecase(tUnpaidParams);

    // assert
    expect(result, const Right(tUnpaidProcedure));
  });
}
