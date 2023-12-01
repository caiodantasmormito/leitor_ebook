import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_de_ebooks/app/modules/home/home_module.dart';


class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    
    r.module('/', module: HomeModule());
  }
}
