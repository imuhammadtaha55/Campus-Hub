import 'package:flutter/material.dart';

import '../../core/app_drawer.dart';
import '../../core/app_routes.dart';
import '../../core/app_theme.dart';
import 'web_page_panel.dart';

class UiShowcaseScreen extends StatelessWidget {
  const UiShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery: size of the whole screen.
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 600 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(title: const Text('UI Showcase')),
      drawer: const AppDrawer(currentRoute: AppRoutes.showcase),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---- Text ----
          Text(
            'Flutter Widget Gallery',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Common widgets and layout patterns'),
          const SizedBox(height: 16),

          // ---- Container + Icon + Row + Expanded ----
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.soft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.widgets, size: 32, color: AppTheme.primary),
                SizedBox(width: 12),
                Expanded(child: Text('Container, Icon, Row and Expanded')),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ---- Card + Column + Buttons ----
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buttons and Card',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Button pressed')),
                        ),
                        child: const Text('Filled Button'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Outlined Button'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Text Button'),
                      ),
                      IconButton(
                        tooltip: 'Favorite',
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ---- Image ----
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                alignment: Alignment.center,
                color: Colors.black12,
                child: const Text('Image could not be loaded'),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ---- Image from assets ----
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/campus.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                alignment: Alignment.center,
                color: Colors.black12,
                child: const Text('Asset image not found'),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ---- Stack + Positioned ----
          SizedBox(
            height: 130,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Icon(Icons.school, color: Colors.white, size: 34),
                ),
                const Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text(
                    'Stack: widgets can overlap',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Positioned(
                  right: 16,
                  top: 16,
                  child: Icon(Icons.star, color: AppTheme.accent, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ---- Expanded vs Flexible ----
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expanded vs Flexible',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Both share the free space in a Row. Expanded forces its '
                    'child to fill its share; Flexible lets the child stay '
                    'only as wide as it needs.',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          color: AppTheme.mid,
                          child: const Text('Expanded'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          color: AppTheme.accent,
                          child: const Text('Flexible'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ---- Grid (columns depend on width) ----
          Text(
            'Grid: $columns columns at ${width.toStringAsFixed(0)} px wide',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: const [
              _GridTile(icon: Icons.book, label: 'Courses'),
              _GridTile(icon: Icons.event, label: 'Events'),
              _GridTile(icon: Icons.task_alt, label: 'Tasks'),
              _GridTile(icon: Icons.person, label: 'Profile'),
            ],
          ),
          const SizedBox(height: 12),

          // ---- LayoutBuilder (Column on narrow, Row on wide) ----
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 500;
              const first = _InfoCard(
                title: 'Row / Column',
                text: 'Arrange children horizontally or vertically.',
              );
              const second = _InfoCard(
                title: 'LayoutBuilder',
                text: 'Stacks in a Column on narrow screens and sits '
                    'side by side in a Row on wide ones.',
              );
              return compact
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [first, second],
                    )
                  : const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: first),
                        SizedBox(width: 12),
                        Expanded(child: second),
                      ],
                    );
            },
          ),
          const SizedBox(height: 12),

          // ---- WebView ----
          const Text(
            'Embedded web page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const WebPagePanel(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _GridTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: AppTheme.primary),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String text;

  const _InfoCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(text),
          ],
        ),
      ),
    );
  }
}
