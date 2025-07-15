import 'package:flutter/material.dart';
import 'package:lumo_book/presentation/widgets/appBar_builder.dart';
import '../../core/config/design_config.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/user_avatar_picker.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder(title: 'Account', automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavigation(currentIndex: 4),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: UserAvatarPicker(radius: 60)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Guest User',
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.headerSize,
                    fontFamily: DesignConfig.fontFamily,
                    fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                _showInfo(
                  context,
                  'Change Password is disabled in guest mode.',
                );
              },
              child: Text(
                'Change password',
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.textSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                _showInfo(context, 'Delete Account is disabled in guest mode.');
              },
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: DesignConfig.deleteCart,
                  fontSize: DesignConfig.textSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.fontWeight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                _showInfo(context, 'Logout is disabled in guest mode.');
              },
              child: Text(
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

  void _showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
