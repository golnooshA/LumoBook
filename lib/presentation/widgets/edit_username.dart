import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class EditUserName extends StatelessWidget {
  final String displayName;
  final bool isEditing;
  final TextEditingController controller;
  final VoidCallback onEditTap;
  final VoidCallback onConfirm;

  const EditUserName({
    super.key,
    required this.displayName,
    required this.isEditing,
    required this.controller,
    required this.onEditTap,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 180,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(isDense: true),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: onConfirm,
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.headerSize,
                  fontFamily: DesignConfig.fontFamily,
                  fontWeight: DesignConfig.semiBold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: DesignConfig.secondColor),
                onPressed: onEditTap,
              ),
            ],
          );
  }
}
