// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpStore on _SignUpBaseStore, Store {
  Computed<bool>? _$passwordsDoNotMatchComputed;

  @override
  bool get passwordsDoNotMatch => (_$passwordsDoNotMatchComputed ??=
          Computed<bool>(() => super.passwordsDoNotMatch,
              name: '_SignUpBaseStore.passwordsDoNotMatch'))
      .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_SignUpBaseStore.canSubmit'))
          .value;

  late final _$_emailAtom =
      Atom(name: '_SignUpBaseStore._email', context: context);

  @override
  String get _email {
    _$_emailAtom.reportRead();
    return super._email;
  }

  @override
  set _email(String value) {
    _$_emailAtom.reportWrite(value, super._email, () {
      super._email = value;
    });
  }

  late final _$_passwordAtom =
      Atom(name: '_SignUpBaseStore._password', context: context);

  @override
  String get _password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  late final _$_confirmPasswordAtom =
      Atom(name: '_SignUpBaseStore._confirmPassword', context: context);

  @override
  String get _confirmPassword {
    _$_confirmPasswordAtom.reportRead();
    return super._confirmPassword;
  }

  @override
  set _confirmPassword(String value) {
    _$_confirmPasswordAtom.reportWrite(value, super._confirmPassword, () {
      super._confirmPassword = value;
    });
  }

  late final _$signUpStateAtom =
      Atom(name: '_SignUpBaseStore.signUpState', context: context);

  @override
  SignUpState get signUpState {
    _$signUpStateAtom.reportRead();
    return super.signUpState;
  }

  @override
  set signUpState(SignUpState value) {
    _$signUpStateAtom.reportWrite(value, super.signUpState, () {
      super.signUpState = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_SignUpBaseStore._errorMessage', context: context);

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

  late final _$_userModelAtom =
      Atom(name: '_SignUpBaseStore._userModel', context: context);

  @override
  UserModel? get _userModel {
    _$_userModelAtom.reportRead();
    return super._userModel;
  }

  @override
  set _userModel(UserModel? value) {
    _$_userModelAtom.reportWrite(value, super._userModel, () {
      super._userModel = value;
    });
  }

  late final _$signUpAsyncAction =
      AsyncAction('_SignUpBaseStore.signUp', context: context);

  @override
  Future<void> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  late final _$_SignUpBaseStoreActionController =
      ActionController(name: '_SignUpBaseStore', context: context);

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$_SignUpBaseStoreActionController.startAction(
        name: '_SignUpBaseStore.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$_SignUpBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$_SignUpBaseStoreActionController.startAction(
        name: '_SignUpBaseStore.changePassword');
    try {
      return super.changePassword(value);
    } finally {
      _$_SignUpBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeConfirmPassword(String value) {
    final _$actionInfo = _$_SignUpBaseStoreActionController.startAction(
        name: '_SignUpBaseStore.changeConfirmPassword');
    try {
      return super.changeConfirmPassword(value);
    } finally {
      _$_SignUpBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleError(String reason) {
    final _$actionInfo = _$_SignUpBaseStoreActionController.startAction(
        name: '_SignUpBaseStore.handleError');
    try {
      return super.handleError(reason);
    } finally {
      _$_SignUpBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signUpState: ${signUpState},
passwordsDoNotMatch: ${passwordsDoNotMatch},
canSubmit: ${canSubmit}
    ''';
  }
}
