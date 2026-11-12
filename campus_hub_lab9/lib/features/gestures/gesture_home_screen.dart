import 'package:flutter/material.dart';

import '../../core/app_drawer.dart';
import '../../core/app_routes.dart';
import 'app_state.dart';
import 'playground_screen.dart';

/// Lab 09 "Home" screen. The body contains only three widgets:
///   1. Text            - shows the shared state
///   2. GestureDetector - the Gesture Pad (tap / double tap / long press)
///   3. ElevatedButton  - opens the Playground
class GestureHomeScreen extends StatelessWidget {
  const GestureHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Lab')),
      drawer: const AppDrawer(currentRoute: AppRoutes.gestures),
      body: ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Widget 1: Text (shows state)
                Text(
                  'Counter: ${appState.counter} | '
                  'Swipes: ${appState.swipeCount} | '
                  'Last: ${appState.lastGesture}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),

                // Widget 2: Gesture Pad (tap, double tap, long press)
                GestureDetector(
                  onTap: appState.tap,
                  onDoubleTap: appState.doubleTap,
                  onLongPress: appState.longPress,
                  child: Container(
                    width: 220,
                    height: 220,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: appState.padColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Gesture Pad\nTap: +1\nDouble tap: +2\nHold: new colour',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Widget 3: Button (navigation)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlaygroundScreen(),
                      ),
                    );
                  },
                  child: const Text('Open Playground'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
