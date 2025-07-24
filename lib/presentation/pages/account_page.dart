import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/config/design_config.dart';
import '../widgets/app_bar_builder.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/edit_username.dart';
import '../widgets/user_avatar.dart';
import 'login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _localPhoto;
  bool _isUploading = false;
  bool _isEditingName = false;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLocalImage();
    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? '';
  }

  Future<void> _pickAndSaveLocalImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => _isUploading = true);

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final savedImagePath = '${appDir.path}/profile.jpg';
      final savedImage = await File(pickedFile.path).copy(savedImagePath);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('local_profile_image', savedImage.path);

      if (!mounted) return;
      setState(() {
        _localPhoto = savedImage;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile photo updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isUploading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadLocalImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final imagePath = prefs.getString('local_profile_image');

      if (imagePath != null && File(imagePath).existsSync()) {
        if (!mounted) return;
        setState(() => _localPhoto = File(imagePath));
      }
    } catch (e) {
      if (!mounted) return;
      debugPrint('Error loading local image: $e');
    }
  }

  Future<void> _updateDisplayName() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(newName);
      await user?.reload();

      if (!mounted) return;
      setState(() => _isEditingName = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update name: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'Guest';

    return Scaffold(
      appBar: AppBarBuilder(title: 'Account', automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavigation(currentIndex: 4),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: UserAvatar(
                    localPhoto: _localPhoto,
                    displayName: displayName,
                    isUploading: _isUploading,
                    onTap: _pickAndSaveLocalImage,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: EditUserName(
                    displayName: displayName,
                    isEditing: _isEditingName,
                    controller: _nameController,
                    onEditTap: () => setState(() => _isEditingName = true),
                    onConfirm: _updateDisplayName,
                  ),
                ),

                const SizedBox(height: 15),
                const Divider(height: 1),
                const SizedBox(height: 15),

                TextButton(
                  onPressed: () => _showChangePasswordDialog(context),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.textSize,
                      fontFamily: DesignConfig.fontFamily,
                      fontWeight: DesignConfig.semiBold,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () => _confirmDeleteAccount(context),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      color: DesignConfig.deleteCart,
                      fontSize: DesignConfig.textSize,
                      fontFamily: DesignConfig.fontFamily,
                      fontWeight: DesignConfig.semiBold,
                    ),
                  ),
                ),

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
                      fontWeight: DesignConfig.semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isUploading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: DesignConfig.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final newPasswordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: DesignConfig.textColor,
            fontSize: DesignConfig.textSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.bold,
          ),
        ),
        content: CustomTextField(
          labelText: 'New Password',
          controller: newPasswordController,
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: DesignConfig.primaryColor,
                fontFamily: DesignConfig.fontFamily,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final newPassword = newPasswordController.text.trim();
              if (newPassword.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password must be at least 6 characters'),
                    backgroundColor: DesignConfig.secondColor,
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
                    const SnackBar(
                      content: Text('Password updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to update password: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: DesignConfig.secondColor,
                fontFamily: DesignConfig.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Account',

          style: TextStyle(
            color: DesignConfig.textColor,
            fontSize: DesignConfig.textSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.bold,
          ),
        ),
        content: const Text('Are you sure you want to delete your account?',

          style: TextStyle(
          color: DesignConfig.textColor,
          fontSize: DesignConfig.subTextSize,
          fontFamily: DesignConfig.fontFamily,
          fontWeight: DesignConfig.light,
        ),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: DesignConfig.primaryColor,
                fontFamily: DesignConfig.fontFamily,
              ),
            ),
          ),

          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('local_profile_image');
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) await user.delete();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete account: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: DesignConfig.deleteCart,
                fontFamily: DesignConfig.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
