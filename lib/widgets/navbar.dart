import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:officeos/theme/theme_notifier.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final bool transparent;
  final List<Widget>? action;

  const Navbar({
    super.key,
    this.title = "",
    this.backButton = false,
    this.transparent = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return AppBar(
      backgroundColor: transparent ? Colors.transparent : (isDark ? Colors.black : Colors.white),
      elevation: transparent ? 0 : 4,
      automaticallyImplyLeading: false,
      leading: backButton
          ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: textColor),
        onPressed: () => Navigator.pop(context),
      )
          : Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: textColor),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (action != null) ...action!,
        Consumer<ThemeNotifier>(
          builder: (_, themeNotifier, __) => IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: () => themeNotifier.toggleTheme(!isDark),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
