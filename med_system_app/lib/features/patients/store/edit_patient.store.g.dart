// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_patient.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditPatientStore on _EditPatientStoreBase, Store {
  Computed<bool>? _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_EditPatientStoreBase.isValidData'))
          .value;

  late final _$saveStateAtom =
      Atom(name: '_EditPatientStoreBase.saveState', context: context);

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
      Atom(name: '_EditPatientStoreBase._errorMessage', context: context);

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
      Atom(name: '_EditPatientStoreBase._patientName', context: context);

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

  late final _$editPatientAsyncAction =
      AsyncAction('_EditPatientStoreBase.editPatient', context: context);

  @override
  Future editPatient(int patientId) {
    return _$editPatientAsyncAction.run(() => super.editPatient(patientId));
  }

  late final _$_EditPatientStoreBaseActionController =
      ActionController(name: '_EditPatientStoreBase', context: context);

  @override
  void setNamePatient(String namePatient) {
    final _$actionInfo = _$_EditPatientStoreBaseActionController.startAction(
        name: '_EditPatientStoreBase.setNamePatient');
    try {
      return super.setNamePatient(namePatient);
    } finally {
      _$_EditPatientStoreBaseActionController.endAction(_$actionInfo);
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
