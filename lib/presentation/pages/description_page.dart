import 'package:flutter/material.dart';
import 'package:lumo_book/presentation/widgets/appBar_builder.dart';

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

      appBar: AppBarBuilder(title: 'Description'),
      bottomNavigationBar:  const BottomNavigation(currentIndex: 1),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            description,
            style: TextStyle(
              color: DesignConfig.textColor,
              fontFamily: DesignConfig.fontFamily,
              fontWeight: DesignConfig.fontWeight,
              fontSize: DesignConfig.textSize,
            ),
          ) ),
      ),

    );
  }
}





