import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/config/design_config.dart';

class UserAvatarPicker extends StatefulWidget {
  final double radius;

  const UserAvatarPicker({super.key, this.radius = 50});

  @override
  State<UserAvatarPicker> createState() => _UserAvatarPickerState();
}

class _UserAvatarPickerState extends State<UserAvatarPicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);

      final picked = await _picker.pickImage(source: source, imageQuality: 85);

      if (picked != null) {
        setState(() => _imageFile = File(picked.path));
      }
    } catch (e) {
      debugPrint('Image pick error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showPickerOptions() {
    final textStyle = TextStyle(
      fontFamily: DesignConfig.fontFamily,
      fontWeight: DesignConfig.semiBold,
      fontSize: DesignConfig.textSize,
      color: DesignConfig.textColor,
    );

    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text('Take Photo', style: textStyle),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Choose from Gallery', style: textStyle),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _showPickerOptions,
          child: CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            child: _imageFile == null
                ? Icon(Icons.person,
                size: widget.radius * 0.6, color: Colors.grey)
                : null,
          ),
        ),

        if (_isLoading)
          Container(
            width: widget.radius * 2,
            height: widget.radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3),
            ),
            child: const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              ),
            ),
          ),

        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: _showPickerOptions,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.camera_alt, size: 16, color: Colors.teal),
            ),
          ),
        ),
      ],
    );
  }
}
