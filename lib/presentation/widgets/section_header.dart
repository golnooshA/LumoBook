import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.headerSize,
              fontWeight: DesignConfig.fontWeightBold,
              color: DesignConfig.textColor
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'more >',
              style: TextStyle(
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.headerSize,
                color: DesignConfig.orange,
                fontWeight: DesignConfig.fontWeightLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
