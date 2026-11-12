import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'features/explore/explore_screen.dart';
import 'features/gestures/gesture_home_screen.dart';
import 'features/home/domain/task_repository.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/showcase/ui_showcase_screen.dart';
import 'features/splash/splash_screen.dart';

class CampusHubApp extends StatelessWidget {
  final TaskRepository repository;

  const CampusHubApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
      routes: {
        AppRoutes.home: (_) => HomeScreen(repository: repository),
        AppRoutes.explore: (_) => const ExploreScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
        AppRoutes.showcase: (_) => const UiShowcaseScreen(),
        AppRoutes.gestures: (_) => const GestureHomeScreen(),
      },
    );
  }
}
