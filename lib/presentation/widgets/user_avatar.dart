import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class UserAvatar extends StatelessWidget {
  final File? localPhoto;
  final String displayName;
  final bool isUploading;
  final VoidCallback onTap;

  const UserAvatar({
    super.key,
    required this.localPhoto,
    required this.displayName,
    required this.isUploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: DesignConfig.primaryColor.withOpacity(0.2),
          backgroundImage: localPhoto != null ? FileImage(localPhoto!) : null,
          child: localPhoto == null
              ? Text(
            displayName.isNotEmpty
                ? displayName[0].toUpperCase()
                : '',
            style: const TextStyle(
              fontSize: 40,
              color: DesignConfig.subTextColor,
              fontWeight: DesignConfig.semiBold,
              fontFamily: DesignConfig.fontFamily,
            ),
          )
              : null,
        ),
        if (!isUploading)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: DesignConfig.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
      ],
    );
  }
}
