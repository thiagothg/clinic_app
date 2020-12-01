// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_atendente_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeAtendenteController = BindInject(
  (i) => HomeAtendenteController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeAtendenteController on _HomeAtendenteControllerBase, Store {
  Computed<Function> _$editPressedComputed;

  @override
  Function get editPressed =>
      (_$editPressedComputed ??= Computed<Function>(() => super.editPressed,
              name: '_HomeAtendenteControllerBase.editPressed'))
          .value;

  final _$sampleAtom = Atom(name: '_HomeAtendenteControllerBase.sample');

  @override
  ObservableList<String> get sample {
    _$sampleAtom.reportRead();
    return super.sample;
  }

  @override
  set sample(ObservableList<String> value) {
    _$sampleAtom.reportWrite(value, super.sample, () {
      super.sample = value;
    });
  }

  final _$dropDownValueAtom =
      Atom(name: '_HomeAtendenteControllerBase.dropDownValue');

  @override
  String get dropDownValue {
    _$dropDownValueAtom.reportRead();
    return super.dropDownValue;
  }

  @override
  set dropDownValue(String value) {
    _$dropDownValueAtom.reportWrite(value, super.dropDownValue, () {
      super.dropDownValue = value;
    });
  }

  final _$formKeyAtom = Atom(name: '_HomeAtendenteControllerBase.formKey');

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
      Atom(name: '_HomeAtendenteControllerBase.contextGlobal');

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

  final _$isLoadingAtom = Atom(name: '_HomeAtendenteControllerBase.isLoading');

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

  final _$clinicModelAtom =
      Atom(name: '_HomeAtendenteControllerBase.clinicModel');

  @override
  ClinicModel get clinicModel {
    _$clinicModelAtom.reportRead();
    return super.clinicModel;
  }

  @override
  set clinicModel(ClinicModel value) {
    _$clinicModelAtom.reportWrite(value, super.clinicModel, () {
      super.clinicModel = value;
    });
  }

  final _$onTapEditAsyncAction =
      AsyncAction('_HomeAtendenteControllerBase.onTapEdit');

  @override
  Future onTapEdit() {
    return _$onTapEditAsyncAction.run(() => super.onTapEdit());
  }

  final _$_HomeAtendenteControllerBaseActionController =
      ActionController(name: '_HomeAtendenteControllerBase');

  @override
  dynamic setDropDownValue(String value) {
    final _$actionInfo = _$_HomeAtendenteControllerBaseActionController
        .startAction(name: '_HomeAtendenteControllerBase.setDropDownValue');
    try {
      return super.setDropDownValue(value);
    } finally {
      _$_HomeAtendenteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sample: ${sample},
dropDownValue: ${dropDownValue},
formKey: ${formKey},
contextGlobal: ${contextGlobal},
isLoading: ${isLoading},
clinicModel: ${clinicModel},
editPressed: ${editPressed}
    ''';
  }
}
