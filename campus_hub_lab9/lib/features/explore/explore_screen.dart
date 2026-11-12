import 'package:flutter/material.dart';

import '../../core/app_drawer.dart';
import '../../core/app_routes.dart';

/// Moved out of HomeScreen in Lab 08 so it can be its own named route.
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      drawer: const AppDrawer(currentRoute: AppRoutes.explore),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.event_outlined),
              title: Text('Upcoming events'),
              subtitle: Text('Workshop, seminar, and society activities'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: Text('Learning resources'),
              subtitle: Text('Notes and project ideas'),
            ),
          ),
        ],
      ),
    );
  }
}
