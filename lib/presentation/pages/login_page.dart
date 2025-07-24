import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../../core/config/routes.dart';
import '../providers/auth_provider.dart';
import '../widgets/button_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signIn(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    } on FirebaseAuthException catch (e) {
      _showError(_getFriendlyErrorMessage(e));
    } catch (_) {
      _showError('Unexpected error occurred. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    } catch (_) {
      _showError('Google sign-in failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getFriendlyErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF5F8FE),
          body: AbsorbPointer(
            absorbing: _isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: ListView(
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: DesignConfig.primaryColor,
                      fontSize: DesignConfig.subTitleSize,
                      fontFamily: DesignConfig.fontFamily,
                      fontWeight: DesignConfig.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We've missed you",
                    style: TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.subTextSize,
                      fontFamily: DesignConfig.fontFamily,
                      fontWeight: DesignConfig.light,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    labelText: 'Email',
                    controller: _emailCtrl,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Password',
                    controller: _passwordCtrl,
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ButtonText(
                    title: 'Sign In',
                    onTap: _login,
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
                    onTap: _loginWithGoogle,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: DesignConfig.primaryColor,
                          fontSize: DesignConfig.subTextSize,
                          fontFamily: DesignConfig.fontFamily,
                          fontWeight: DesignConfig.semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    DesignConfig.primaryColor),
              ),
            ),
          ),
      ],
    );
  }
}
