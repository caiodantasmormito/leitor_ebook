import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_de_ebooks/app/modules/home/external/repository/book_repository_impl.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/controllers/home_controller.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/repository/book_repository.dart';
import 'package:leitor_de_ebooks/app/modules/home/presenter/pages/home_page.dart';
import 'package:leitor_de_ebooks/app/services/http_client_service.dart';
import 'package:leitor_de_ebooks/app/services/local_storage_service.dart';
import 'package:leitor_de_ebooks/app/services/shared_save_imp.dart';

import '../../services/dio_client_imp.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ILocalStorageService>(SharedSaveImpl.new);
    i.add<IHttpClient>(DioClientImpl.new);
    i.add<BookRepository>(BookRepositoryImpl.new);
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute,
        child: (context) => const HomePage(), transition: TransitionType.size);
  }
}
