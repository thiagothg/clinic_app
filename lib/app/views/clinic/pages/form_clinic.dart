import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controllers/clinic_controller.dart';
import '../../../core/consts/app_conts.dart';
import '../../../shared/validation/validation.dart';
import '../../../shared/widgets/form_button.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../../shared/widgets/text_form_field.dart';

class FormClinic extends StatefulWidget {
  final bool view;
  final String labelButton;
  final Function onTapButton;
  final Function buttonPressed;
  
  const FormClinic({Key key, 
    this.view = false, 
    this.labelButton = '', 
    this.onTapButton, this.buttonPressed}) : super(key: key);


  @override
  _FormClinicState createState() => _FormClinicState();
}

class _FormClinicState extends ModularState<FormClinic, ClinicController> {
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
                  readOnly: widget.view
                ),
                SizedBox(height: 15),
                textFormField(
                  controller: controller.nameTextController,
                  labelText: 'Nome',
                  validator: validateName,
                  textColor: Colors.grey,
                  readOnly: widget.view
                ),
                SizedBox(height: 15),
                textFormField(
                  controller: controller.phoneTextController,
                  labelText: 'Telefone',
                  validator: validatePhone,
                  textColor: Colors.grey,
                  readOnly: widget.view
                ),
                SizedBox(height: 15),
                textFormField(
                  controller: controller.enderecoController,
                  labelText: 'Endereço',
                  validator: validateEnd,
                  textColor: Colors.grey,
                  readOnly: true,
                  onTap: !widget.view ? () async {
                    var p = await PlacesAutocomplete.show(
                      hint: 'Procurar',
                      context: context, 
                      apiKey: ConstsApp.apiKeyGooglePlaces,
                      language: 'pt',
                      onError: (e) {
                        print(e.errorMessage);
                        GlobalScaffold.instance.createSnackBar(
                          text: "Error: ${e?.errorMessage}",
                          background: Theme.of(context).errorColor
                        ); 
                      }
                    );
                    if (p != null) {
                        // get detail (lat/lng)
                        var detail = await controller
                          .places
                          .getDetailsByPlaceId(p.placeId);
                        final lat = detail.result.geometry.location.lat;
                        final lng = detail.result.geometry.location.lng;
                        controller.enderecoController.text = p.description;
                        controller.endDetail = detail;

                        GlobalScaffold.instance.createSnackBar(
                          text: "${p.description} - $lat/$lng",
                          background: Theme.of(context).primaryColor
                        );
                    }
                  } : null
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
          : controller.setDropDownValue,
    );
  }
}