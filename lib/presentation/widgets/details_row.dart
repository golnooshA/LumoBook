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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: DesignConfig.fontWeight,
              color: DesignConfig.subTextColor,
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.subTextSize,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: DesignConfig.fontWeight,
                color: DesignConfig.textColor,
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.subTextSize,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
