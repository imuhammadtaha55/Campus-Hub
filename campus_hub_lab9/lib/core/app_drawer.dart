import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'app_theme.dart';

/// Main navigation for Campus Hub (replaces the Lab 07 bottom NavigationBar).
/// Every main screen passes its own route name as [currentRoute].
class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  static const _destinations = <_Destination>[
    _Destination(AppRoutes.home, 'Home', Icons.home_outlined, Icons.home),
    _Destination(
        AppRoutes.explore, 'Explore', Icons.explore_outlined, Icons.explore),
    _Destination(
        AppRoutes.profile, 'Profile', Icons.person_outline, Icons.person),
    _Destination(AppRoutes.showcase, 'UI Showcase', Icons.widgets_outlined,
        Icons.widgets),
    _Destination(AppRoutes.gestures, 'Gesture Lab', Icons.touch_app_outlined,
        Icons.touch_app),
  ];

  void _go(BuildContext context, String route) {
    Navigator.pop(context); // close the drawer first
    if (route == currentRoute) return;

    if (route == AppRoutes.home) {
      // Go back to the existing Home (keeps its state and tasks).
      Navigator.popUntil(context, ModalRoute.withName(AppRoutes.home));
    } else if (currentRoute == AppRoutes.home) {
      // Home stays underneath so Back returns to it.
      Navigator.pushNamed(context, route);
    } else {
      // Switching between secondary screens: replace, so the stack
      // stays Home -> current screen instead of growing.
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = _destinations.indexWhere((d) => d.route == currentRoute);

    return NavigationDrawer(
      selectedIndex: selected < 0 ? null : selected,
      onDestinationSelected: (index) =>
          _go(context, _destinations[index].route),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(28, 48, 16, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primary, AppTheme.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Icon(Icons.school, color: AppTheme.primary, size: 30),
              ),
              SizedBox(height: 12),
              Text(
                'Campus Hub',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Muhammad Taha', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        for (final d in _destinations)
          NavigationDrawerDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.selectedIcon),
            label: Text(d.label),
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About this lab'),
          onTap: () {
            Navigator.pop(context);
            showAboutDialog(
              context: context,
              applicationName: 'Campus Hub',
              applicationVersion: '3.0.0',
              children: const [
                Text('Lab 09: gestures and shared state (Gesture Lab).'),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Destination {
  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _Destination(this.route, this.label, this.icon, this.selectedIcon);
}
