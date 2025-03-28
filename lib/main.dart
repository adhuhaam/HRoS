import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/auth/login.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/profile/profile.dart';

// Theme
import 'theme/theme.dart';
import 'theme/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const HrosApp(),
    ),
  );
}

class HrosApp extends StatelessWidget {
  const HrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) {
        return MaterialApp(
          title: 'HROS',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.themeMode,
          initialRoute: '/login',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(builder: (_) => const LoginPage());

              case '/dashboard':
                final empNo = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => DashboardPage(empNo: empNo),
                );

              case '/profile':
                final empNo = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => ProfilePage(empNo: empNo),
                );

              default:
                return MaterialPageRoute(
                  builder: (_) => const Scaffold(
                    body: Center(child: Text("Page not found")),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
