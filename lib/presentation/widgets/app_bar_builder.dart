import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;

  const AppBarBuilder({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textScale = MediaQuery.of(context).textScaleFactor;

    final double fontSize = screenWidth > 600
        ? DesignConfig.appBarTitleFontSize * 1.2
        : DesignConfig.appBarTitleFontSize * textScale;

    return AppBar(
      backgroundColor: DesignConfig.appBarBackgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading && leading == null,
      leading: leading,
      centerTitle: true,
      actions: actions,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: DesignConfig.appBarTitleColor,
          fontSize: fontSize,
          fontFamily: DesignConfig.fontFamily,
          fontWeight: DesignConfig.semiBold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
