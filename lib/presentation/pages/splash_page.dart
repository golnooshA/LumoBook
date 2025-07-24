import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/design_config.dart';
import '../../core/config/routes.dart';
import '../providers/auth_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (user) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          Navigator.pushReplacementNamed(
            context,
            user == null ? Routes.login : Routes.home,
          );
        });

        return Scaffold(
          backgroundColor: DesignConfig.primaryColor,
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              width: 220,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: DesignConfig.border,
                image: const DecorationImage(
                  image: AssetImage('assets/image/logo_2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
