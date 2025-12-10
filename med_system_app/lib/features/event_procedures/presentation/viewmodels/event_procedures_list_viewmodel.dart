import 'dart:io';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/get_event_procedures_usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

import 'package:distrito_medico/features/event_procedures/domain/usecases/delete_event_procedure_usecase.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/update_event_procedure_payment_usecase.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/generate_event_procedure_pdf_usecase.dart';

part 'event_procedures_list_viewmodel.g.dart';

// ignore: library_private_types_in_public_api
class EventProceduresListViewModel = _EventProceduresListViewModelBase
    with _$EventProceduresListViewModel;

abstract class _EventProceduresListViewModelBase with Store {
  final GetEventProceduresUseCase _getEventProceduresUseCase;
  final DeleteEventProcedureUseCase _deleteEventProcedureUseCase;
  final UpdateEventProcedurePaymentUseCase _updateEventProcedurePaymentUseCase;

  /* Filters State */
  int? _currentMonth;
  int? _currentYear;
  bool? _currentPaid;
  String? _currentHealthInsuranceName;
  String? _currentHospitalName;

  @observable
  String? pdfPath;

  @observable
  bool isPdfLoading = false;

  final GenerateEventProcedurePdfUseCase _generateEventProcedurePdfUseCase;

  _EventProceduresListViewModelBase(
    this._getEventProceduresUseCase,
    this._deleteEventProcedureUseCase,
    this._updateEventProcedurePaymentUseCase,
    this._generateEventProcedurePdfUseCase,
  );

  @observable
  ObservableList<EventProcedureEntity> eventProcedures =
      ObservableList<EventProcedureEntity>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  /* Filter Properties */
  @observable
  int page = 1;

  @observable
  int perPage = 10;

  @observable
  String? total;

  @observable
  String? totalPaid;

  @observable
  String? totalUnpaid;

  @action
  Future<void> loadEventProcedures({
    int? month,
    int? year,
    bool? paid,
    String? healthInsuranceName,
    String? hospitalName,
    bool refresh = false,
  }) async {
    if (refresh) {
      page = 1;
      eventProcedures.clear();
      // Update filters only on refresh/explicit load
      _currentMonth = month;
      _currentYear = year;
      _currentPaid = paid;
      _currentHealthInsuranceName = healthInsuranceName;
      _currentHospitalName = hospitalName;
    }

    isLoading = true;
    errorMessage = null;

    final result = await _getEventProceduresUseCase(GetEventProceduresParams(
      page: page,
      perPage: perPage,
      month: _currentMonth,
      year: _currentYear,
      paid: _currentPaid,
      healthInsuranceName: _currentHealthInsuranceName,
      hospitalName: _currentHospitalName,
    ));

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
        isLoading = false;
      },
      (data) {
        if (refresh) {
          eventProcedures.clear();
        }
        eventProcedures.addAll(data.items);
        total = data.total;
        totalPaid = data.totalPaid;
        totalUnpaid = data.totalUnpaid;
        
        if (data.items.isNotEmpty) {
          page++;
        }
        
        isLoading = false;
      },
    );
  }

  @action
  Future<void> deleteEventProcedure(int id) async {
    isLoading = true;
    errorMessage = null;

    final result = await _deleteEventProcedureUseCase(DeleteEventProcedureParams(id: id));

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
        isLoading = false;
      },
      (_) {
        eventProcedures.removeWhere((element) => element.id == id);
        isLoading = false;
      },
    );
  }

  @action
  Future<void> updatePaymentStatus(int id, bool paid) async {
    isLoading = true;
    errorMessage = null;

    // Find the current event procedure to get its payment type
    final currentEvent = eventProcedures.firstWhere(
      (element) => element.id == id,
      orElse: () => const EventProcedureEntity(),
    );

    // Get current payment type or default to 'health_insurance'
    final paymentType = currentEvent.payment ?? 'health_insurance';
    
    // Set paidAt to current date if marking as paid, otherwise null
    final paidAt = paid ? DateTime.now().toIso8601String() : null;

    final result = await _updateEventProcedurePaymentUseCase(
      UpdateEventProcedurePaymentParams(
        id: id, 
        paid: paid,
        paidAt: paidAt,
        payment: paymentType,
      ),
    );

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
        isLoading = false;
      },
      (updatedEntity) {
        final index = eventProcedures.indexWhere((element) => element.id == id);
        if (index != -1) {
          eventProcedures[index] = updatedEntity;
        }
        isLoading = false;
      },
    );
  }

  @action
  Future<void> generatePdf() async {
    isPdfLoading = true;
    pdfPath = null;
    errorMessage = null;

    final result = await _generateEventProcedurePdfUseCase(GenerateEventProcedurePdfParams(
      month: _currentMonth,
      year: _currentYear,
      paid: _currentPaid,
      healthInsuranceName: _currentHealthInsuranceName,
      hospitalName: _currentHospitalName,
    ));

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
        isPdfLoading = false;
      },
      (bytes) async {
        try {
          final directory = await getApplicationDocumentsDirectory();
          final path = '${directory.path}/report.pdf';
          final file = File(path);
          await file.writeAsBytes(bytes);
          pdfPath = path;
        } catch (e) {
          errorMessage = 'Erro ao salvar PDF: $e';
        } finally {
          isPdfLoading = false;
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Erro ao conectar com o servidor.';
    }
    return 'Ocorreu um erro inesperado.';
  }
}
