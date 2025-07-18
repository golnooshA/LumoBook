import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumo_book/presentation/widgets/appBar_builder.dart';
import 'package:lumo_book/presentation/widgets/button_text.dart';
import '../../core/config/design_config.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/user_avatar_picker.dart';
import 'login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final displayName = (user?.displayName?.trim().isNotEmpty ?? false)
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'Guest';

    return Scaffold(
      appBar: AppBarBuilder(title: 'Account', automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavigation(currentIndex: 4),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(child: UserAvatarPicker(radius: 60)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                displayName,
                style: const TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.headerSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
            const SizedBox(height: 30),

            /// Change Password
            TextButton(
              onPressed: () => _showChangePasswordDialog(context),
              child: const Text(
                'Change Password',
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.textSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),

            /// Delete Account
            TextButton(
              onPressed: () => _confirmDeleteAccount(context),
              child: const Text(
                'Delete Account',
                style: TextStyle(
                  color: DesignConfig.deleteCart,
                  fontSize: DesignConfig.textSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),

            /// Logout
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: DesignConfig.primaryColor,
                  fontSize: DesignConfig.textSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Change Password',
            style: TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.headerSize,
              color: DesignConfig.primaryColor,
              fontWeight: DesignConfig.fontWeight,
            ),
          ),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  labelText: 'New Password',
                  controller: newPasswordController,
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  color: DesignConfig.subTextColor,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final newPassword = newPasswordController.text.trim();

                if (newPassword.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Password must be at least 6 characters',
                        style: TextStyle(
                          fontFamily: DesignConfig.fontFamily,
                          fontSize: DesignConfig.textSize,
                          color: DesignConfig.textColor,
                          fontWeight: DesignConfig.fontWeight,
                        ),
                      ),
                    ),
                  );
                  return;
                }

                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await user.updatePassword(newPassword);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password updated successfully')),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Error')),
                  );
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  color: DesignConfig.orange,
                  fontWeight: DesignConfig.fontWeightBold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Account',
            style: TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.headerSize,
              color: DesignConfig.primaryColor,
              fontWeight: DesignConfig.fontWeight,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.textSize,
              color: DesignConfig.textColor,
              fontWeight: DesignConfig.fontWeight,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  color: DesignConfig.subTextColor,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) await user.delete();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.message ?? 'Error',
                        style: TextStyle(
                          fontFamily: DesignConfig.fontFamily,
                          fontSize: DesignConfig.textSize,
                          color: DesignConfig.textColor,
                          fontWeight: DesignConfig.fontWeight,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  color: DesignConfig.deleteCart,
                  fontWeight: DesignConfig.fontWeightBold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
