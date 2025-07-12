import 'package:flutter/material.dart';

import '../../core/config/design_config.dart';
import '../widgets/bottom_navigation.dart';

class DescriptionPage extends StatelessWidget {
  final String description;

  const DescriptionPage({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: DesignConfig.appBarBackgroundColor,
          centerTitle: true,
          title: Text(
            'Description',
            style: TextStyle(
              color: DesignConfig.appBarTitleColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: DesignConfig.appBarTitleFontSize,
            ),
          )),
      bottomNavigationBar:  const BottomNavigation(currentIndex: 1),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            description,
            style: TextStyle(
              color: DesignConfig.textColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: DesignConfig.textSize,
            ),
          ) ),
      ),

    );
  }
}





