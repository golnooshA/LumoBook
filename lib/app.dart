import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/widgets/error_screen.dart';
import 'presentation/widgets/loading_screen.dart';

class LumoApp extends ConsumerWidget {
  const LumoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Lumo Book App',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final orientation = mediaQuery.orientation;
        final screenSize = mediaQuery.size;

        return OrientationBuilder(
          builder: (context, orientation) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaleFactor: mediaQuery.textScaleFactor.clamp(1.0, 1.2),
                  ),
                  child: child!,
                );
              },
            );
          },
        );
      },

      home: authState.when(
        data: (user) => user != null ? const HomePage() : const LoginPage(),
        loading: () => const LoadingScreen(),
        error: (err, _) => ErrorScreen(message: err.toString()),
      ),

      routes: {
        Routes.login: (_) => const LoginPage(),
        Routes.register: (_) => const RegisterPage(),
        Routes.home: (_) => const HomePage(),
      },
    );
  }
}
