import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class RoundButton extends StatelessWidget {
  final String buttonText;

  const RoundButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 20 : 16,
        vertical: isTablet ? 10 : 8,
      ),
      decoration: BoxDecoration(
        color: DesignConfig.lightBlue,
        borderRadius: DesignConfig.border,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          buttonText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: DesignConfig.textSize * scale,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.light,
            color: DesignConfig.textColor,
          ),
        ),
      ),
    );
  }
}
