// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$userEmailAtom =
      Atom(name: '_AppStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$selectedLanguageAtom =
      Atom(name: '_AppStore.selectedLanguage', context: context);

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$uidAtom = Atom(name: '_AppStore.uid', context: context);

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  late final _$userProfileAtom =
      Atom(name: '_AppStore.userProfile', context: context);

  @override
  String get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(String value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  late final _$isDarkModeOnAtom =
      Atom(name: '_AppStore.isDarkModeOn', context: context);

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  late final _$addPropertyIndexAtom =
      Atom(name: '_AppStore.addPropertyIndex', context: context);

  @override
  int get addPropertyIndex {
    _$addPropertyIndexAtom.reportRead();
    return super.addPropertyIndex;
  }

  @override
  set addPropertyIndex(int value) {
    _$addPropertyIndexAtom.reportWrite(value, super.addPropertyIndex, () {
      super.addPropertyIndex = value;
    });
  }

  late final _$setLoginAsyncAction =
      AsyncAction('_AppStore.setLogin', context: context);

  @override
  Future<void> setLogin(bool val, {bool isInitializing = false}) {
    return _$setLoginAsyncAction
        .run(() => super.setLogin(val, isInitializing: isInitializing));
  }

  late final _$setLoadingAsyncAction =
      AsyncAction('_AppStore.setLoading', context: context);

  @override
  Future<void> setLoading(bool val) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(val));
  }

  late final _$setUserEmailAsyncAction =
      AsyncAction('_AppStore.setUserEmail', context: context);

  @override
  Future<void> setUserEmail(String val, {bool isInitialization = false}) {
    return _$setUserEmailAsyncAction
        .run(() => super.setUserEmail(val, isInitialization: isInitialization));
  }

  late final _$setUIdAsyncAction =
      AsyncAction('_AppStore.setUId', context: context);

  @override
  Future<void> setUId(String val, {bool isInitializing = false}) {
    return _$setUIdAsyncAction
        .run(() => super.setUId(val, isInitializing: isInitializing));
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('_AppStore.setLanguage', context: context);

  @override
  Future<void> setLanguage(String aCode, {BuildContext? context}) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(aCode, context: context));
  }

  late final _$setDarkModeAsyncAction =
      AsyncAction('_AppStore.setDarkMode', context: context);

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
selectedLanguage: ${selectedLanguage},
isLoading: ${isLoading},
isLoggedIn: ${isLoggedIn},
uid: ${uid},
userProfile: ${userProfile},
isDarkModeOn: ${isDarkModeOn},
addPropertyIndex: ${addPropertyIndex}
    ''';
  }
}
