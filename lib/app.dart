import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumo_book/presentation/pages/home_page.dart';
import 'package:lumo_book/presentation/pages/login_page.dart';
import 'package:lumo_book/presentation/pages/regiester_page.dart';
import 'package:lumo_book/presentation/pages/splash_page.dart';
import '../core/theme/app_theme.dart';
import 'core/config/routes.dart';

class LumoApp extends ConsumerWidget {
  const LumoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Lumo Book App',
      theme: AppTheme.light(),
      home: const RegisterPage(),

      // Optional: If you plan to navigate using named routes
      routes: {
        Routes.home: (_) => const HomePage(),
      },
    );
  }
}
