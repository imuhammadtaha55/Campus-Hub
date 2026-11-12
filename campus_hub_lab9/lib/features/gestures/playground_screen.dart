import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import 'app_state.dart';

/// Lab 09 Playground: drag, pinch, double tap (reset), horizontal swipe
/// and vertical swipe, all writing to the shared [appState].
class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  // Local state: the box scale at the moment a pinch starts.
  double _baseScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      body: ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          return Column(
            children: [
              const SizedBox(height: 16),

              // Shows the SAME shared state as the Home screen.
              Text(
                'Counter: ${appState.counter} | '
                'Swipes: ${appState.swipeCount} | '
                'Last: ${appState.lastGesture}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),

              // Drag + pinch area (Task 2: double tap resets the box).
              Expanded(
                child: GestureDetector(
                  onDoubleTap: appState.resetBox,
                  onScaleStart: (details) {
                    _baseScale = appState.boxScale;
                  },
                  onScaleUpdate: (details) {
                    appState.moveAndScale(
                      details.focalPointDelta,
                      _baseScale * details.scale,
                    );
                  },
                  child: ClipRect(
                    child: Container(
                      color: AppTheme.soft,
                      width: double.infinity,
                      child: Center(
                        child: Transform.translate(
                          offset: appState.boxOffset,
                          child: Transform.scale(
                            scale: appState.boxScale,
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: const Text(
                                'Drag / Pinch',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Swipe card: horizontal changes the counter,
              // vertical (Task 4) changes the box scale.
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  final v = details.primaryVelocity ?? 0;
                  if (v > 0) appState.swipe(true);
                  if (v < 0) appState.swipe(false);
                },
                onVerticalDragEnd: (details) {
                  final v = details.primaryVelocity ?? 0;
                  if (v < 0) appState.verticalSwipe(true); // up
                  if (v > 0) appState.verticalSwipe(false); // down
                },
                child: Card(
                  margin: const EdgeInsets.all(16),
                  color: Colors.amber.shade200,
                  child: const SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        '<< Swipe left / right: counter ±10 >>\n'
                        'Swipe up / down: box size x1.2 / ÷1.2',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
