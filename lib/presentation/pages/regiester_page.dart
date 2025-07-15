import 'package:flutter/material.dart';
import 'package:lumo_book/core/config/design_config.dart';

import '../widgets/button_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FE),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: ListView(
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                color: DesignConfig.primaryColor,
                fontSize: DesignConfig.subTitleSize,
                fontFamily: DesignConfig.fontFamily,
                fontWeight: DesignConfig.fontWeightBold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sign Up to get started buddy",
              style: TextStyle(
                color: DesignConfig.textColor,
                fontSize: DesignConfig.subTextSize,
                fontFamily: DesignConfig.fontFamily,
                fontWeight: DesignConfig.fontWeightLight,
              ),
            ),
            const SizedBox(height: 32),
            const CustomTextField(labelText: 'Full Name'),
            const SizedBox(height: 20),
            const CustomTextField(labelText: 'Email'),
            const SizedBox(height: 20),
            const CustomTextField(labelText: 'Password', obscureText: true),
            const SizedBox(height: 24),
            ButtonText(
              title: 'Sign Up',
              onTap: () {},
              backgroundColor: DesignConfig.primaryColor,
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Or'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            SocialButton(
              title: 'Sign Up with Google',
              imagePath: 'assets/icon/google_icon.png',
              onTap: () {},
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Already got an account? Sign In",
                  style: TextStyle(
                    color: DesignConfig.primaryColor,
                    fontSize: DesignConfig.subTextSize,
                    fontFamily: DesignConfig.fontFamily,
                    fontWeight: DesignConfig.fontWeight,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
