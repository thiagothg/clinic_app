import 'package:clinic_app/app/controllers/atendente_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'form_atendente.dart';

class AddAtendentePage extends StatefulWidget {
  @override
  _AddAtendentePageState createState() => _AddAtendentePageState();
}

class _AddAtendentePageState extends ModularState<AddAtendentePage, AtendenteController> {

  @override
  void initState() { 
    super.initState();
    
    controller.contextGlobal = context;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Atendente',
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormAtendentePage(
          labelButton: 'Salvar',
          buttonPressed: controller.savePressed,
        ),
      )
    );
  }

  // Widget form() {
  //   return Form(
  //     key: controller.formKey,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             children: [
  //               SizedBox(height: 25),
  //               textFormField(
  //                 controller: controller.cnpfTextController,
  //                 labelText: 'CNPJ',
  //                 validator: validateCnpj,
  //                 textColor: Colors.grey,
  //               ),
  //               SizedBox(height: 15),
  //               textFormField(
  //                 controller: controller.nameTextController,
  //                 labelText: 'Nome',
  //                 validator: validateName,
  //                 textColor: Colors.grey
  //               ),
  //               SizedBox(height: 15),
  //               textFormField(
  //                 controller: controller.phoneTextController,
  //                 labelText: 'Telefone',
  //                 validator: validatePhone,
  //                 textColor: Colors.grey
  //               ),
  //               SizedBox(height: 15),
  //               textFormField(
  //                 controller: controller.enderecoController,
  //                 labelText: 'Endereço',
  //                 validator: validateEnd,
  //                 textColor: Colors.grey,
  //                 readOnly: true,
  //                 onTap: () async {
  //                   var p = await PlacesAutocomplete.show(
  //                     hint: 'Procurar',
  //                     context: context, 
  //                     apiKey: ConstsApp.apiKeyGooglePlaces,
  //                     language: 'pt',
  //                     onError: (e) {
  //                       print(e);
  //                     }
  //                   );
  //                   if (p != null) {
  //                       // get detail (lat/lng)
  //                       var detail = await controller.places.getDetailsByPlaceId(p.placeId);
  //                       final lat = detail.result.geometry.location.lat;
  //                       final lng = detail.result.geometry.location.lng;
  //                       controller.enderecoController.text = p.description;
  //                       controller.endDetail = detail;

  //                        GlobalScaffold.instance.createSnackBar(
  //                         text: "${p.description} - $lat/$lng",
  //                         background: Theme.of(context).primaryColor
  //                       );
  //                   }
  //                 }
  //               ),
  //               SizedBox(height: 50),
  //               formButton(
  //                 context,
  //                 text: 'Salvar',
  //                 onTap: () {
  //                   controller.onTapSave();
  //                 },
  //               ),
  //             ],
  //           ),

  //         ],
  //       )
  //     )
  //   );
  // }
}