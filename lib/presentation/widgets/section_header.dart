import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Semantics(
        container: true,
        label: '$title section header with see more button',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.headerSize * (isTablet ? 1.2 : scale),
                  fontWeight: DesignConfig.bold,
                  color: DesignConfig.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // More button
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 32),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Text(
                'more >',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.headerSize * scale,
                  color: DesignConfig.secondColor,
                  fontWeight: DesignConfig.light,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
