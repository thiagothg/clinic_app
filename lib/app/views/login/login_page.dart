import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controllers/login_controller.dart';
import '../../shared/widgets/custom_icon_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Hero(
                  tag: 'hero',
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 75.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Observer(
                          builder: (_){
                            return CustomTextField(
                              hint: 'Usuário',
                              prefix: Icon(Icons.account_circle),
                              textInputType: TextInputType.emailAddress,
                              onChanged: controller.setUsuario,
                              enabled: !controller.loading,
                            );
                          },
                        ),
                        const SizedBox(height: 16,),
                        Observer(
                          builder: (_){
                            return CustomTextField(
                              hint: 'Senha',
                              prefix: Icon(Icons.lock),
                              obscure: !controller.passwordVisible,
                              onChanged: controller.setPassword,
                              enabled: !controller.loading,
                              suffix: CustomIconButton(
                                radius: 32,
                                iconData: controller.passwordVisible ?
                                  Icons.visibility_off : Icons.visibility,
                                onTap: controller.togglePasswordVisibility,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25,),
                        Observer(
                          builder: (_){
                            return SizedBox(
                              height: 44,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: controller.loading ?
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation
                                    (Colors.white),
                                  ) : Text('Login'),
                                color: Theme.of(context).primaryColor,
                                disabledColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                                textColor: Colors.white,
                                onPressed: controller.loginPressed,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
