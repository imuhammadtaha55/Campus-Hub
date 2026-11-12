
import 'package:flutter/material.dart';
import '../../../core/app_drawer.dart';
import '../../../core/app_routes.dart';
import '../domain/task.dart';
import '../domain/task_repository.dart';
import 'add_task_screen.dart';
import 'animated_welcome_card.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  /// Shared repository, created once in main.dart. Because it is passed in
  /// (not created here), tasks survive navigation between screens.
  final TaskRepository repository;

  const HomeScreen({super.key, required this.repository});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskRepository get _repository => widget.repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Hub'),
        actions: [
          IconButton(
            tooltip: 'Add task',
            icon: const Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: AppRoutes.home),
      body: SafeArea(child: _buildHomeContent()),
    );
  }

  Widget _buildHomeContent() {
    final tasks = _repository.getTasks();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Good morning!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        const Text('Your student workspace at a glance.'),
        const SizedBox(height: 16),
        const AnimatedWelcomeCard(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Tasks',
                value: '${tasks.length}',
                icon: Icons.checklist,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: _StatCard(
                title: 'Courses',
                value: '3',
                icon: Icons.menu_book_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'My tasks',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        ...tasks.map(
          (task) => Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.task_alt),
              ),
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openTask(task),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: _addTask,
          icon: const Icon(Icons.add),
          label: const Text('Add a task'),
        ),
      ],
    );
  }

  void _openTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskDetailScreen(task: task),
      ),
    ).then((_) => setState(() {}));
  }

  Future<void> _addTask() async {
    final task = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddTaskScreen(),
      ),
    );

    if (task != null) {
      setState(() => _repository.addTask(task));
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
