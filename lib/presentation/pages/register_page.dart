import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lumo_book/core/config/design_config.dart';
import '../../core/config/routes.dart';
import '../providers/auth_provider.dart';
import '../widgets/button_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameCtrl  = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).register(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
      Navigator.pushReplacementNamed(context, Routes.home);
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Registration failed');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _registerWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      _showError('Google sign-in failed: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
            CustomTextField(
              labelText: 'Full Name',
              controller: _nameCtrl,
            ),
            const SizedBox(height: 20),
            CustomTextField(labelText: 'Email',
                controller: _emailCtrl),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Password',
              obscureText: true,
              controller: _passwordCtrl,
            ),
            const SizedBox(height: 24),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              ButtonText(
                title: 'Sign Up',
                onTap: _register,
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
                onTap: _registerWithGoogle,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
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
              ),
            ],


          ],
        ),
      ),
    );
  }
}


