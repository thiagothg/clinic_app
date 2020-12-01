// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ClinicController = BindInject(
  (i) => ClinicController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClinicController on _ClinicControllerBase, Store {
  Computed<Function> _$editPressedComputed;

  @override
  Function get editPressed =>
      (_$editPressedComputed ??= Computed<Function>(() => super.editPressed,
              name: '_ClinicControllerBase.editPressed'))
          .value;
  Computed<Function> _$savePressedComputed;

  @override
  Function get savePressed =>
      (_$savePressedComputed ??= Computed<Function>(() => super.savePressed,
              name: '_ClinicControllerBase.savePressed'))
          .value;

  final _$formKeyAtom = Atom(name: '_ClinicControllerBase.formKey');

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

  final _$contextGlobalAtom = Atom(name: '_ClinicControllerBase.contextGlobal');

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

  final _$geoAtom = Atom(name: '_ClinicControllerBase.geo');

  @override
  Geoflutterfire get geo {
    _$geoAtom.reportRead();
    return super.geo;
  }

  @override
  set geo(Geoflutterfire value) {
    _$geoAtom.reportWrite(value, super.geo, () {
      super.geo = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ClinicControllerBase.isLoading');

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

  final _$endDetailAtom = Atom(name: '_ClinicControllerBase.endDetail');

  @override
  PlacesDetailsResponse get endDetail {
    _$endDetailAtom.reportRead();
    return super.endDetail;
  }

  @override
  set endDetail(PlacesDetailsResponse value) {
    _$endDetailAtom.reportWrite(value, super.endDetail, () {
      super.endDetail = value;
    });
  }

  final _$clinicModelAtom = Atom(name: '_ClinicControllerBase.clinicModel');

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

  final _$sampleAtom = Atom(name: '_ClinicControllerBase.sample');

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

  final _$dropDownValueAtom = Atom(name: '_ClinicControllerBase.dropDownValue');

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

  final _$onTapSaveAsyncAction = AsyncAction('_ClinicControllerBase.onTapSave');

  @override
  Future onTapSave() {
    return _$onTapSaveAsyncAction.run(() => super.onTapSave());
  }

  final _$onTapEditAsyncAction = AsyncAction('_ClinicControllerBase.onTapEdit');

  @override
  Future onTapEdit() {
    return _$onTapEditAsyncAction.run(() => super.onTapEdit());
  }

  final _$_ClinicControllerBaseActionController =
      ActionController(name: '_ClinicControllerBase');

  @override
  dynamic setDropDownValue(String value) {
    final _$actionInfo = _$_ClinicControllerBaseActionController.startAction(
        name: '_ClinicControllerBase.setDropDownValue');
    try {
      return super.setDropDownValue(value);
    } finally {
      _$_ClinicControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
contextGlobal: ${contextGlobal},
geo: ${geo},
isLoading: ${isLoading},
endDetail: ${endDetail},
clinicModel: ${clinicModel},
sample: ${sample},
dropDownValue: ${dropDownValue},
editPressed: ${editPressed},
savePressed: ${savePressed}
    ''';
  }
}
