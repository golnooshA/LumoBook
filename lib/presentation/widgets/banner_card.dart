import 'package:flutter/material.dart';

import '../../core/config/design_config.dart';

class BannerCard extends StatelessWidget {
  final String image;

  const BannerCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      width: 220,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: DesignConfig.cardBorder,
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
      ),
    );
  }
}
