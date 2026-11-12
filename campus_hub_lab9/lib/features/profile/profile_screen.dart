import 'package:flutter/material.dart';

import '../../core/app_drawer.dart';
import '../../core/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const AppDrawer(currentRoute: AppRoutes.profile),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          const CircleAvatar(
            radius: 42,
            child: Icon(Icons.person, size: 44),
          ),
          const SizedBox(height: 12),
          Text(
            'Muhammad Taha',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Text(
            '233152@students.au.pk',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Card(
            child: ListTile(
              leading: Icon(Icons.school_outlined),
              title: Text('Program'),
              subtitle: Text('BS Information Technology'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: Text('Semester'),
              subtitle: Text('Semester 7'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('App information'),
              subtitle: const Text('Campus Hub — lab prototype'),
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'Campus Hub',
                children: const [Text('Built during a beginner Flutter lab.')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
