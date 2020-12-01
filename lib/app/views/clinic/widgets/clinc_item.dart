import 'package:clinic_app/app/controllers/clinic_controller.dart';
import 'package:clinic_app/app/core/enums/app_enums.dart';
import 'package:clinic_app/app/models/clinic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicItem extends StatefulWidget {
  final ClinicModel model;

  const ClinicItem({Key key, this.model}) : super(key: key);
  
  @override
  _ClinicItemState createState() => _ClinicItemState();
}

class _ClinicItemState extends ModularState<ClinicItem, ClinicController> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: clinicDescription(),
                ),
                popUpMenuButton()
              ],
            ),
          ),
          // Divider(),
        ]
      ),
    );
  }

  Widget clinicDescription() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.hospitalAlt,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Flexible(
                  child: Text(
                widget.model.name,
                style: TextStyle(fontSize: 17),
              )),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cnpj: ${widget.model.cnpj}',
                overflow: TextOverflow.fade,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('End: ${widget.model.end}'),
              ),
              Text('Telefone: ${widget.model.phone}'),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget popUpMenuButton() {
    return PopupMenuButton(
      onSelected: (value) {
        print(value);
        controller.onTapPopUpMenuItem(
          context,
          selectedMenuItem: value,
          idClinic: widget.model.id,
        );
      },
      icon: Icon(
        Icons.menu,
        color: Theme.of(context).primaryColor,
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          popUpMenuItem(
            text: 'Visualizar',
            iconData: Icons.search,
            iconColor: Theme.of(context).primaryColor,
            value: PopUpMenuOptions.readItem,
          ),
          popUpMenuItem(
            text: 'Editar',
            iconData: Icons.edit,
            iconColor: Colors.amber,
            value: PopUpMenuOptions.editItem,
          ),
          popUpMenuItem(
            text: 'Excluir',
            iconData: Icons.close,
            iconColor: Colors.red,
            value: PopUpMenuOptions.deleteItem,
          ),
        ];
      },
    );
  }

  PopupMenuItem popUpMenuItem({
    @required String text,
    @required IconData iconData,
    @required Color iconColor,
    @required PopUpMenuOptions value,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            iconData,
            color: iconColor,
          ),
          Text(text),
          Container(),
        ],
      ),
    );
  }
}