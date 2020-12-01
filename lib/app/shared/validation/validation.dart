

import 'package:cpfcnpj/cpfcnpj.dart';

String validateEmail(String email) =>
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)
        ? null
        : 'Email inválido';

String validatePassword(String password) =>
    password.length >= 6 ? null : 'A senha deve ter no mínimo 6 caracteres';

String validateName(String name) =>
    name.length >= 3 ? null : 'O nome deve ter no mínimo 3 caracteres';

String validateCnpj(String cnpj) => 
  (CNPJ.isValid(cnpj)) ? null : 'CNPJ inválido';

String validatePhone(String phone) =>
    RegExp(r"^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$")
            .hasMatch(phone)
        ? null
        : 'Telefone inválido';

String validateEnd(String end) =>
    end.length >= 2 ? null : 'Endereço inválido';

String validateLogin(String name) =>
    name.length >= 3 ? null : 'O login deve ter no mínimo 3 caracteres';
