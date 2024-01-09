// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInStore on _SignInBaseStore, Store {
  late final _$_currentUserAtom =
      Atom(name: '_SignInBaseStore._currentUser', context: context);

  @override
  UserModel? get _currentUser {
    _$_currentUserAtom.reportRead();
    return super._currentUser;
  }

  @override
  set _currentUser(UserModel? value) {
    _$_currentUserAtom.reportWrite(value, super._currentUser, () {
      super._currentUser = value;
    });
  }

  late final _$_emailAtom =
      Atom(name: '_SignInBaseStore._email', context: context);

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
      Atom(name: '_SignInBaseStore._password', context: context);

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

  late final _$signInStateAtom =
      Atom(name: '_SignInBaseStore.signInState', context: context);

  @override
  SignInState get signInState {
    _$signInStateAtom.reportRead();
    return super.signInState;
  }

  @override
  set signInState(SignInState value) {
    _$signInStateAtom.reportWrite(value, super.signInState, () {
      super.signInState = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: '_SignInBaseStore._errorMessage', context: context);

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

  late final _$_SignInBaseStoreActionController =
      ActionController(name: '_SignInBaseStore', context: context);

  @override
  dynamic setCurrentUser(UserModel userModelResponse) {
    final _$actionInfo = _$_SignInBaseStoreActionController.startAction(
        name: '_SignInBaseStore.setCurrentUser');
    try {
      return super.setCurrentUser(userModelResponse);
    } finally {
      _$_SignInBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$_SignInBaseStoreActionController.startAction(
        name: '_SignInBaseStore.changeEmail');
    try {
      return super.changeEmail(value);
    } finally {
      _$_SignInBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$_SignInBaseStoreActionController.startAction(
        name: '_SignInBaseStore.changePassword');
    try {
      return super.changePassword(value);
    } finally {
      _$_SignInBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signInState: ${signInState}
    ''';
  }
}
