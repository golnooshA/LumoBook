import 'package:flutter/material.dart';
import 'package:lumo_book/core/config/design_config.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConfig.primaryColor, // blue background
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          width: 220,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: DesignConfig.cardBorder,
            image: const DecorationImage(
              image: AssetImage('assets/image/logo_2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
