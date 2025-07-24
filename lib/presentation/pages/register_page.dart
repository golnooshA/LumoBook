import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../../core/config/routes.dart';
import '../providers/auth_provider.dart';
import '../widgets/button_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import 'login_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailCtrl = TextEditingController();
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

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) await user.reload();

      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    } on FirebaseAuthException catch (e) {
      _showError(_getFriendlyErrorMessage(e));
    } catch (_) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _registerWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    } catch (_) {
      _showError('Google sign-up failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getFriendlyErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'network-request-failed':
        return 'No internet connection. Try again.';
      default:
        return 'Registration failed. Please try again.';
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
                    'Create Account',
                    style: TextStyle(
                      color: DesignConfig.primaryColor,
                      fontSize: DesignConfig.subTitleSize,
                      fontFamily: DesignConfig.fontFamily,
                      fontWeight: DesignConfig.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign Up to get started buddy",
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
                    obscureText: true,
                    controller: _passwordCtrl,
                  ),
                  const SizedBox(height: 24),
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
