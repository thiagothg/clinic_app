import 'package:clinic_app/app/controllers/atendente_controller.dart';
import 'package:clinic_app/app/shared/validation/validation.dart';
import 'package:clinic_app/app/shared/widgets/custom_icon_button.dart';
import 'package:clinic_app/app/shared/widgets/form_button.dart';
import 'package:clinic_app/app/shared/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormAtendentePage extends StatefulWidget {
  final bool view;
  final String labelButton;
  final Function onTapButton;
  final Function buttonPressed;
  
  const FormAtendentePage({Key key, this.view = false, this.labelButton, this.onTapButton, this.buttonPressed}) : super(key: key);

  @override
  _FormAtendentePageState createState() => _FormAtendentePageState();
}

class _FormAtendentePageState extends ModularState<FormAtendentePage, AtendenteController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: form(),
        ),
      )
    );
  }

  Widget form() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10),
        textFormField(
          controller: controller.nameTextController,
          labelText: 'Atendente',
          validator: validateName,
          textColor: widget.view
                  ? Colors.grey
                  : Colors.black,
          readOnly: widget.view 
        ),
        SizedBox(height: 15),
        textFormField(
          controller: controller.phoneTextController,
          labelText: 'Celular',
          validator: validatePhone,
          textColor: Colors.grey,
          readOnly: widget.view
        ),
        SizedBox(height: 15),
        textFormField(
          controller: controller.loginTextController,
          labelText: 'Login',
          validator: validatePassword,
          textColor: Colors.grey,
          readOnly: widget.view
        ),
        SizedBox(height: 15),
        Observer(
          builder: (_) {
            return textFormField(
              labelText: 'Senha',
              controller: controller.passwordTextController,
              validator: validatePassword,
              readOnly: false,
              obscureText: !controller.passwordVisible,
              textColor: Colors.grey,
              suffix: CustomIconButton(
                radius: 32,
                iconData: controller.passwordVisible ?
                  Icons.visibility_off : Icons.visibility,
                onTap: controller.togglePasswordVisibility,
              ),
            );
          }
        ),

        SizedBox(height: 15),
        clinicTextField(),
        SizedBox(height: 35),

        (!widget.view) 
        ? submitButton(
          context,
          text: widget.labelButton,
          onTap: widget.onTapButton,
          loading: controller.isLoading,
          loginPressed: widget.buttonPressed
        ) : Container()

      ],
    );
  }

  Widget clinicTextField() {
    return TextFormField(
      readOnly: true,
      controller: controller.clinicTextController,
      style: TextStyle(
        color: Colors.grey
      ),
      validator: (String value) {
        return value.length != 0 ? null : 'Selecione uma clínica';
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: (widget.view)
            ? null
            : () {
            controller.fetchClinica(context);
          },
        ),
        border: OutlineInputBorder(),
        labelText: 'Clínica',
      )
    );
  }
}