import 'package:clinic_app/app/controllers/atendente/home_atendente_controller.dart';
import 'package:clinic_app/app/controllers/clinic_controller.dart';
import 'package:clinic_app/app/core/consts/app_conts.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:clinic_app/app/shared/validation/validation.dart';
import 'package:clinic_app/app/shared/widgets/form_button.dart';
import 'package:clinic_app/app/shared/widgets/global_scaffold.dart';
import 'package:clinic_app/app/shared/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormClinic extends StatefulWidget {
  final bool view;
  final String labelButton;
  final Function onTapButton;
  final Function buttonPressed;
  final ClinicModel model;
  
  const FormClinic({Key key, 
    this.view = false, 
    this.labelButton = '', 
    this.onTapButton, this.buttonPressed, this.model}) : super(key: key);


  @override
  _FormClinicState createState() => _FormClinicState();
}

class _FormClinicState extends ModularState<FormClinic, HomeAtendenteController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 25),
                textFormField(
                  controller: controller.cnpfTextController,
                  labelText: 'CNPJ',
                  validator: validateCnpj,
                  textColor: Colors.grey,
                  readOnly: widget.view,
                  initialValue: widget.model.cnpj
                ),
                SizedBox(height: 15),
                textFormField(
                  controller: controller.nameTextController,
                  labelText: 'Nome',
                  validator: validateName,
                  textColor: Colors.grey,
                  readOnly: widget.view,
                  initialValue: widget.model.name
                ),
                SizedBox(height: 15),
                textFormField(
                  controller: controller.phoneTextController,
                  labelText: 'Telefone',
                  validator: validatePhone,
                  textColor: Colors.grey,
                  readOnly: widget.view,
                  initialValue: widget.model.phone
                ),
                SizedBox(height: 15),
                textFormField(
                  controller: controller.enderecoController,
                  labelText: 'Endereço',
                  validator: validateEnd,
                  textColor: Colors.grey,
                  readOnly: true,
                  initialValue: widget.model.end
                ),
                SizedBox(height: 15),
                statusClinic(readOnly: false),
                SizedBox(height: 50),
                (!widget.view) 
                ? 
                submitButton(
                  context,
                  text: widget.labelButton,
                  onTap: widget.onTapButton,
                  loading: controller.isLoading,
                  loginPressed: widget.buttonPressed
                ) : Container()
              ],
            ),

          ],
        )
      )
    );
  }

  Widget statusClinic({bool readOnly = false}) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Status',
      ),
      isExpanded: true,
      items: controller.sample.map((service) {
        return DropdownMenuItem(
          child: Text(service),
          value: service,
        );
      }).toList(),
      value: controller.dropDownValue,
      onChanged: readOnly
          ? null
          : (String value) {
              controller.setDropDownValue(value);
            },
    );
  }
}