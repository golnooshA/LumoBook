import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class RoundButton extends StatelessWidget {
  final String buttonText;

  const RoundButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: DesignConfig.light_light_blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: DesignConfig.textSize),
      ),
    );
  }
}
