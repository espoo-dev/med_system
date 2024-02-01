// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_patient.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddPatientStore on _AddPatientStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_AddPatientStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_AddPatientStoreBase.saveState', context: context);

  @override
  SavePatientState get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(SavePatientState value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_AddPatientStoreBase._errorMessage', context: context);

  @override
  String get _errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  set _errorMessage(String value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$_patientNameAtom =
      Atom(name: '_AddPatientStoreBase._patientName', context: context);

  @override
  String get _patientName {
    _$_patientNameAtom.reportRead();
    return super._patientName;
  }

  @override
  set _patientName(String value) {
    _$_patientNameAtom.reportWrite(value, super._patientName, () {
      super._patientName = value;
    });
  }

  late final _$createPatientAsyncAction =
      AsyncAction('_AddPatientStoreBase.createPatient', context: context);

  @override
  Future createPatient() {
    return _$createPatientAsyncAction.run(() => super.createPatient());
  }

  late final _$_AddPatientStoreBaseActionController =
      ActionController(name: '_AddPatientStoreBase', context: context);

  @override
  void setNamePatient(String namePatient) {
    final _$actionInfo = _$_AddPatientStoreBaseActionController.startAction(
        name: '_AddPatientStoreBase.setNamePatient');
    try {
      return super.setNamePatient(namePatient);
    } finally {
      _$_AddPatientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saveState: ${saveState},
isValidData: ${isValidData}
    ''';
  }
}
