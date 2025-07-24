import 'package:flutter/material.dart';
import 'package:lumo_book/presentation/widgets/app_bar_builder.dart';
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
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Text(
                  description,
                  style: const TextStyle(
                    color: DesignConfig.textColor,
                    fontFamily: DesignConfig.fontFamily,
                    fontWeight: DesignConfig.semiBold,
                    fontSize: DesignConfig.textSize,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
