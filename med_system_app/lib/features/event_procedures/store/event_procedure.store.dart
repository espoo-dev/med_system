import 'dart:io';
import 'dart:typed_data';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/core/api/api_result.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:distrito_medico/features/event_procedures/model/edit_payment_procedure_request.model.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/repository/event_procedure_repository.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:distrito_medico/features/health_insurances/repository/health_insurances_repository.dart';
import 'package:distrito_medico/features/hospitals/model/hospital.model.dart';
import 'package:distrito_medico/features/hospitals/respository/hospital_repository.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'event_procedure.store.g.dart';

class EventProcedureStore = _EventProcedureStore with _$EventProcedureStore;

enum EventProcedureState { idle, success, error, loading }

enum EditEventProcedureState { idle, success, error, loading }

enum DeleteEventProcedureState { idle, success, error, loading }

enum FilterProcedureState { idle, success, error, loading }

enum PdfReportState { idle, success, error, loading }

abstract class _EventProcedureStore with Store {
  final EventProcedureRepository _eventProcedureRepository;
  final HospitalRepository _hospitalRepository;
  final HealthInsurancesRepository _healthInsurancesRepository;

  ObservableList<EventProcedures> eventProcedureList =
      ObservableList<EventProcedures>();

  ObservableList<EventProcedures> eventProcedureListCalendar =
      ObservableList<EventProcedures>();

  @observable
  FilterProcedureState filterState = FilterProcedureState.idle;

  @observable
  EventProcedureState state = EventProcedureState.idle;
  @observable
  EditEventProcedureState editState = EditEventProcedureState.idle;

  @observable
  DeleteEventProcedureState deleteSate = DeleteEventProcedureState.idle;

  ObservableList<Hospital> hospitalList = ObservableList<Hospital>();
  ObservableList<HealthInsurance> healthInsuranceList =
      ObservableList<HealthInsurance>();

  @observable
  Hospital? _hospital;

  Hospital? get hospital => _hospital;

  @observable
  PdfReportState pdfState = PdfReportState.idle;

  @observable
  String pdfErrorMessage = "";

  @observable
  String _pdfPath = "";
  get pdfPath => _pdfPath;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  int _page = 1;
  get page => _page;

  @observable
  EventProcedureModel? _eventProcedureModel = EventProcedureModel();
  get eventProcedureModel => _eventProcedureModel;

  @observable
  int? selectedYear = DateTime.now().year;

  @observable
  int? selectedMonth = DateTime.now().month;

  @observable
  bool? selectedPaymentStatus;

  @observable
  String? hospitalName;

  @observable
  String? healthInsuranceName;

  @observable
  HealthInsurance? _healthInsurance;

  HealthInsurance? get healthInsurance => _healthInsurance;

  _EventProcedureStore(
      EventProcedureRepository eventProcedureRepository,
      HospitalRepository hospitalRepository,
      HealthInsurancesRepository healthInsurancesRepository)
      : _eventProcedureRepository = eventProcedureRepository,
        _hospitalRepository = hospitalRepository,
        _healthInsurancesRepository = healthInsurancesRepository;

  List<int> get years {
    int currentYear = DateTime.now().year;
    return List.generate(20, (index) => currentYear - index);
  }

  List<int> get months => List.generate(12, (index) => index + 1);

  @action
  void setSelectedYear(int? year) {
    selectedYear = year;
  }

  @action
  void setSelectedMonth(int? month) {
    selectedMonth = month;
  }

  @action
  void setSelectedPaymentStatus(bool? status) {
    selectedPaymentStatus = status;
  }

  @action
  void setHospitalName(Hospital hospital) {
    _hospital = Hospital(
        id: hospital.id,
        name: hospital.name ?? _hospital?.name ?? "",
        address: hospital.address ?? _hospital?.address ?? "");
    hospitalName = hospital.name;
  }

  @action
  void setHealthInsuranceName(HealthInsurance healthInsurance) {
    _healthInsurance = HealthInsurance(
      // ignore: unnecessary_null_in_if_null_operators
      id: healthInsurance.id ?? null,
      name: healthInsurance.name ?? _healthInsurance?.name ?? "",
    );
    healthInsuranceName = healthInsurance.name;
  }

  @action
  void clearFilters() {
    selectedYear = null;
    selectedMonth = null;
    selectedPaymentStatus = null;
    hospitalName = null;
    healthInsuranceName = null;
  }

  String getMonthName(int month) {
    List<String> months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    return months[month - 1];
  }

  @action
  fetchAllData() async {
    try {
      if (selectedMonth == null && selectedYear == null) {
        selectedYear = DateTime.now().year;
        selectedMonth = DateTime.now().month;
      }
      filterState = FilterProcedureState.loading;
      await Future.wait([
        // Fetch all hospitals
        getAllHospitals(),
        getAllHealthInsurances()
      ]);
      filterState = FilterProcedureState.success;
    } catch (error) {
      filterState = FilterProcedureState.error;
      handleError(error.toString());
    }
  }

  @action
  getAllEventProcedures({bool isRefresh = false}) async {
    Result<EventProcedureModel?>? resultEventProcedures;
    if (isRefresh) {
      _page = 1;
      eventProcedureList.clear();
      eventProcedureListCalendar.clear();
    }
    state = EventProcedureState.loading;
    if (!isRefresh) {
      _page++;
    }
    await Future.delayed(const Duration(seconds: 3));

    resultEventProcedures = await _eventProcedureRepository
        .getEventProceduresByFilters(
            page: _page,
            perPage: 10000,
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            healthInsuranceName: healthInsuranceName,
            hospitalName: hospitalName)
        .asObservable();

    resultEventProcedures?.when(
      success: (EventProcedureModel? eventProcedureModel) {
        _eventProcedureModel = eventProcedureModel;
        handleSuccess(eventProcedureModel?.eventProceduresList);
      },
      failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  @action
  getAllEventProceduresByFilters() async {
    Result<EventProcedureModel?>? resultEventProcedures;
    eventProcedureList.clear();
    eventProcedureListCalendar.clear();
    state = EventProcedureState.loading;

    resultEventProcedures = await _eventProcedureRepository
        .getEventProceduresByFilters(
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            healthInsuranceName: healthInsuranceName,
            hospitalName: hospitalName)
        .asObservable();

    resultEventProcedures?.when(
      success: (EventProcedureModel? eventProcedureModel) {
        _eventProcedureModel = eventProcedureModel;
        handleSuccess(eventProcedureModel?.eventProceduresList);
      },
      failure: (NetworkExceptions error) {
        handleError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  handleSuccess(List<EventProcedures>? listEventProcedures) {
    eventProcedureList.addAll(listEventProcedures!);
    eventProcedureListCalendar.addAll(listEventProcedures!);
    state = EventProcedureState.success;
  }

  handleError(String reason) {
    _errorMessage = reason;
    state = EventProcedureState.error;
  }

  @action
  deleteEventProcedure(int eventProcedureId, index) async {
    deleteSate = DeleteEventProcedureState.loading;
    var deleteResult =
        await _eventProcedureRepository.deleteEventProcedure(eventProcedureId);
    deleteResult?.when(success: (patient) {
      eventProcedureList.removeAt(index);
      deleteSate = DeleteEventProcedureState.success;
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      deleteSate = DeleteEventProcedureState.error;
    });
  }

  @action
  editPaymentEventProcedure(int eventProcedureId, index) async {
    editState = EditEventProcedureState.loading;
    var editResult = await _eventProcedureRepository.editPaymentEventProcedure(
        eventProcedureId, EditPaymentEventProcedureModel(payd: true));
    editResult?.when(success: (eventProcedure) {
      eventProcedureList[index] =
          eventProcedureList[index].copyWith(payd: true);
      editState = EditEventProcedureState.success;
    }, failure: (NetworkExceptions error) {
      editState = EditEventProcedureState.error;
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  String getCurrentDate() {
    DateTime currentDate = DateTime.now();
    String day = currentDate.day.toString().padLeft(2, '0');
    String month = currentDate.month.toString().padLeft(2, '0');
    String year = currentDate.year.toString();
    return '$day/$month/$year';
  }

  @action
  dispose() {
    healthInsuranceList.clear();
    _healthInsurance = null;
    hospitalList.clear();
    _hospital = null;
    eventProcedureList.clear();
    _page = 1;
    _eventProcedureModel = null;
    //selectedMonth = null;
    selectedPaymentStatus = null;
    //selectedYear = null;
    hospitalName = null;
    healthInsuranceName = null;
  }

  @action
  Future<void> generatePdfReportForEventProcedure() async {
    pdfState = PdfReportState.loading;

    Result<Response>? pdfResult =
        await _eventProcedureRepository.generatePdfReport(
            month: selectedMonth,
            year: selectedYear,
            payd: selectedPaymentStatus,
            healthInsuranceName: healthInsuranceName,
            hospitalName: hospitalName);

    pdfResult?.when(
      success: (response) async {
        final pdfBytes = response.bodyBytes;

        _pdfPath = await _savePdfFile(pdfBytes);
        pdfState = PdfReportState.success;
      },
      failure: (NetworkExceptions error) {
        pdfErrorMessage = NetworkExceptions.getErrorMessage(error);
        pdfState = PdfReportState.error;
      },
    );
  }

  Future<String> _savePdfFile(Uint8List pdfBytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = '${directory.path}/report.pdf';

      final pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(pdfBytes);

      return pdfPath;
    } catch (e) {
      pdfErrorMessage = "Erro ao salvar PDF: $e";
      pdfState = PdfReportState.error;
      return '';
    }
  }

  @action
  Future getAllHospitals() async {
    hospitalList.clear();
    var resultHospital =
        await _hospitalRepository.getAllHospitals().asObservable();
    resultHospital?.when(success: (List<Hospital>? listHospital) {
      hospitalList.addAll(listHospital!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  Future getAllHealthInsurances() async {
    healthInsuranceList.clear();

    var resultHealthInsurances =
        await _healthInsurancesRepository.getAllInsurances().asObservable();
    resultHealthInsurances?.when(
        success: (List<HealthInsurance>? listHealthInsurances) {
      healthInsuranceList.addAll(listHealthInsurances!);
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
    });
  }

  @action
  void filterEventProceduresByDate(DateTime selectedDate) {
    // Criar uma nova lista para armazenar os eventos filtrados
    List<EventProcedures> filteredList = [];
    filteredList.clear();

    // Iterando sobre a lista de eventos com forEach
    for (var eventProcedure in eventProcedureListCalendar) {
      // Verificando se a data do evento não está vazia
      if (eventProcedure.date?.isEmpty ?? true) {
        continue; // Ignorar evento com data inválida
      }

      // Convertendo o campo 'date' de EventProcedure (string) para DateTime
      try {
        DateTime eventDate =
            DateFormat('dd/MM/yyyy').parse(eventProcedure.date ?? '');

        // Ajustando as datas para o mesmo horário (meia-noite)
        eventDate = DateTime(eventDate.year, eventDate.month, eventDate.day);
        selectedDate =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

        // Comparando as datas
        if (eventDate.isAtSameMomentAs(selectedDate)) {
          // Adiciona o evento filtrado à lista
          filteredList.add(eventProcedure);
        }
      } catch (e) {
        // Caso ocorra erro no parse
        print(
            "Erro ao parsear a data do evento: ${eventProcedure.date} - Erro: $e");
      }
    }

    // Atualizando o eventProcedureList com os eventos filtrados
    eventProcedureList.clear();
    eventProcedureList.addAll(filteredList);

    // Log para verificação
    print("Lista filtrada atualizada: ${eventProcedureList.length} eventos.");
  }
}
