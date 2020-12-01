// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atendente_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AtendenteController = BindInject(
  (i) => AtendenteController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AtendenteController on _AtendenteControllerBase, Store {
  Computed<Function> _$editPressedComputed;

  @override
  Function get editPressed =>
      (_$editPressedComputed ??= Computed<Function>(() => super.editPressed,
              name: '_AtendenteControllerBase.editPressed'))
          .value;
  Computed<Function> _$savePressedComputed;

  @override
  Function get savePressed =>
      (_$savePressedComputed ??= Computed<Function>(() => super.savePressed,
              name: '_AtendenteControllerBase.savePressed'))
          .value;

  final _$globalScaffoldKeyAtom =
      Atom(name: '_AtendenteControllerBase.globalScaffoldKey');

  @override
  GlobalKey<ScaffoldState> get globalScaffoldKey {
    _$globalScaffoldKeyAtom.reportRead();
    return super.globalScaffoldKey;
  }

  @override
  set globalScaffoldKey(GlobalKey<ScaffoldState> value) {
    _$globalScaffoldKeyAtom.reportWrite(value, super.globalScaffoldKey, () {
      super.globalScaffoldKey = value;
    });
  }

  final _$formKeyAtom = Atom(name: '_AtendenteControllerBase.formKey');

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$contextGlobalAtom =
      Atom(name: '_AtendenteControllerBase.contextGlobal');

  @override
  BuildContext get contextGlobal {
    _$contextGlobalAtom.reportRead();
    return super.contextGlobal;
  }

  @override
  set contextGlobal(BuildContext value) {
    _$contextGlobalAtom.reportWrite(value, super.contextGlobal, () {
      super.contextGlobal = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AtendenteControllerBase.isLoading');

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

  final _$fetchClinicaPopUpConditionAtom =
      Atom(name: '_AtendenteControllerBase.fetchClinicaPopUpCondition');

  @override
  String get fetchClinicaPopUpCondition {
    _$fetchClinicaPopUpConditionAtom.reportRead();
    return super.fetchClinicaPopUpCondition;
  }

  @override
  set fetchClinicaPopUpCondition(String value) {
    _$fetchClinicaPopUpConditionAtom
        .reportWrite(value, super.fetchClinicaPopUpCondition, () {
      super.fetchClinicaPopUpCondition = value;
    });
  }

  final _$selectedClinicIDAtom =
      Atom(name: '_AtendenteControllerBase.selectedClinicID');

  @override
  String get selectedClinicID {
    _$selectedClinicIDAtom.reportRead();
    return super.selectedClinicID;
  }

  @override
  set selectedClinicID(String value) {
    _$selectedClinicIDAtom.reportWrite(value, super.selectedClinicID, () {
      super.selectedClinicID = value;
    });
  }

  final _$passwordVisibleAtom =
      Atom(name: '_AtendenteControllerBase.passwordVisible');

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  final _$_atendenteModelAtom =
      Atom(name: '_AtendenteControllerBase._atendenteModel');

  @override
  AtendenteModel get _atendenteModel {
    _$_atendenteModelAtom.reportRead();
    return super._atendenteModel;
  }

  @override
  set _atendenteModel(AtendenteModel value) {
    _$_atendenteModelAtom.reportWrite(value, super._atendenteModel, () {
      super._atendenteModel = value;
    });
  }

  final _$onTapSaveAsyncAction =
      AsyncAction('_AtendenteControllerBase.onTapSave');

  @override
  Future onTapSave() {
    return _$onTapSaveAsyncAction.run(() => super.onTapSave());
  }

  final _$onTapEditAsyncAction =
      AsyncAction('_AtendenteControllerBase.onTapEdit');

  @override
  Future onTapEdit() {
    return _$onTapEditAsyncAction.run(() => super.onTapEdit());
  }

  final _$_AtendenteControllerBaseActionController =
      ActionController(name: '_AtendenteControllerBase');

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_AtendenteControllerBaseActionController.startAction(
        name: '_AtendenteControllerBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_AtendenteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFetchClinicaPopUpCondition(String value) {
    final _$actionInfo = _$_AtendenteControllerBaseActionController.startAction(
        name: '_AtendenteControllerBase.setFetchClinicaPopUpCondition');
    try {
      return super.setFetchClinicaPopUpCondition(value);
    } finally {
      _$_AtendenteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedClinicaID(String value) {
    final _$actionInfo = _$_AtendenteControllerBaseActionController.startAction(
        name: '_AtendenteControllerBase.setSelectedClinicaID');
    try {
      return super.setSelectedClinicaID(value);
    } finally {
      _$_AtendenteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
globalScaffoldKey: ${globalScaffoldKey},
formKey: ${formKey},
contextGlobal: ${contextGlobal},
isLoading: ${isLoading},
fetchClinicaPopUpCondition: ${fetchClinicaPopUpCondition},
selectedClinicID: ${selectedClinicID},
passwordVisible: ${passwordVisible},
editPressed: ${editPressed},
savePressed: ${savePressed}
    ''';
  }
}
