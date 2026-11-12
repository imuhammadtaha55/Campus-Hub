import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';

/// Implicit animation: tapping flips [_expanded], and AnimatedContainer
/// smoothly interpolates padding, color and corner radius.
class AnimatedWelcomeCard extends StatefulWidget {
  const AnimatedWelcomeCard({super.key});

  @override
  State<AnimatedWelcomeCard> createState() => _AnimatedWelcomeCardState();
}

class _AnimatedWelcomeCardState extends State<AnimatedWelcomeCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.all(_expanded ? 28 : 16),
        decoration: BoxDecoration(
          color: _expanded ? AppTheme.mid : AppTheme.soft,
          borderRadius: BorderRadius.circular(_expanded ? 24 : 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.waving_hand, size: 30, color: AppTheme.primary),
            const SizedBox(height: 8),
            Text(
              _expanded ? 'Welcome to Campus Hub!' : 'Welcome back!',
              style: textTheme.titleMedium,
            ),
            if (_expanded)
              const Text('Tap again to return to compact view.'),
          ],
        ),
      ),
    );
  }
}
