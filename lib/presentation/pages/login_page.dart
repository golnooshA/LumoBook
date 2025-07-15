import 'package:flutter/material.dart';
import 'package:lumo_book/core/config/design_config.dart';

import '../widgets/button_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FE),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: ListView(
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(
                color: DesignConfig.primaryColor,
                fontSize: DesignConfig.subTitleSize,
                fontFamily: DesignConfig.fontFamily,
                fontWeight: DesignConfig.fontWeightBold,

              ),
            ),
            const SizedBox(height: 8),
            const Text("We've missed you", style: TextStyle(
                color: DesignConfig.textColor,
                fontSize: DesignConfig.subTextSize,
                fontFamily: DesignConfig.fontFamily,
                fontWeight: DesignConfig.fontWeightLight
            ),
              ),
            const SizedBox(height: 32),
            const CustomTextField(labelText: 'Email'),
            const SizedBox(height: 20),
            const CustomTextField(labelText: 'Password', obscureText: true),
            const SizedBox(height: 24),
            ButtonText(
              title: 'Sign In',
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
              title: 'Sign In with Google',
              backgroundColor: Colors.white,
              imagePath: 'assets/icon/google_icon.png',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Don't have an account? Sign Up",
                style: TextStyle(
                    color: DesignConfig.primaryColor,
                    fontSize: DesignConfig.subTextSize,
                    fontFamily: DesignConfig.fontFamily,
                    fontWeight: DesignConfig.fontWeight
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}