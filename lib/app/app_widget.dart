import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_de_ebooks/app/core/themes/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Leitor de Ebooks',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme(),
      routerConfig: Modular.routerConfig,
    );
  }
}
