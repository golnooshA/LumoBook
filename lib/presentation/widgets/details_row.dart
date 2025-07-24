import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class DetailsRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailsRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Ensures tight vertical layout
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 160 : 120,
            ),
            child: Text(
              '$title:',
              style: TextStyle(
                fontWeight: DesignConfig.semiBold,
                color: DesignConfig.subTextColor,
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.subTextSize * scale,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.trim(),
              style: TextStyle(
                fontWeight: DesignConfig.semiBold,
                color: DesignConfig.textColor,
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.subTextSize * scale,
                height: 1.3, // Consistent with title
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
