import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clinic_app/app/controllers/client/home_client_controller.dart';
import 'package:clinic_app/app/modules/home_client/home_client_module.dart';

void main() {
  initModule(HomeClientModule());
  // HomeClientController homeclient;
  //
  setUp(() {
    //     homeclient = HomeClientModule.to.get<HomeClientController>();
  });

  group('HomeClientController Test', () {
    //   test("First Test", () {
    //     expect(homeclient, isInstanceOf<HomeClientController>());
    //   });

    //   test("Set Value", () {
    //     expect(homeclient.value, equals(0));
    //     homeclient.increment();
    //     expect(homeclient.value, equals(1));
    //   });
  });
}
