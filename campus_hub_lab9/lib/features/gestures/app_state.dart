import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/app_theme.dart';

/// Lab 09: shared state for the Gesture Lab screens.
///
/// Every method changes data and then calls notifyListeners(), so each
/// ListenableBuilder listening to [appState] rebuilds with the new values.
class AppState extends ChangeNotifier {
  static const double minScale = 0.5;
  static const double maxScale = 3.0;

  /// Task 1: the three colours the pad can switch between.
  static const List<Color> padColors = [
    AppTheme.primary,
    Colors.teal,
    Colors.deepOrange,
  ];

  final Random _random = Random();

  int counter = 0;
  int swipeCount = 0; // Task 3
  String lastGesture = 'None yet';
  Color padColor = padColors.first;
  Offset boxOffset = Offset.zero;
  double boxScale = 1.0;

  /// Tap: counter +1.
  void tap() {
    counter++;
    lastGesture = 'Tap';
    notifyListeners();
  }

  /// Task 1: double tap now adds 2 to the counter.
  void doubleTap() {
    counter += 2;
    lastGesture = 'Double tap';
    notifyListeners();
  }

  /// Task 1: long press picks a random colour from [padColors].
  /// The current colour is left out of the draw so the change is always
  /// visible (otherwise 1 press in 3 would appear to do nothing).
  void longPress() {
    final options = padColors.where((c) => c != padColor).toList();
    padColor = options[_random.nextInt(options.length)];
    lastGesture = 'Long press';
    notifyListeners();
  }

  /// Drag moves the box, pinch scales it (0.5x to 3x).
  void moveAndScale(Offset delta, double scale) {
    boxOffset += delta;
    boxScale = scale.clamp(minScale, maxScale).toDouble();
    lastGesture = 'Drag / Pinch';
    notifyListeners();
  }

  /// Task 2: put the box back in the centre at normal size.
  void resetBox() {
    boxOffset = Offset.zero;
    boxScale = 1.0;
    lastGesture = 'Reset box';
    notifyListeners();
  }

  /// Horizontal swipe: counter +10 (right) or -10 (left).
  /// Task 3: every swipe also increases [swipeCount].
  void swipe(bool right) {
    counter += right ? 10 : -10;
    swipeCount++;
    lastGesture = right ? 'Swipe right' : 'Swipe left';
    notifyListeners();
  }

  /// Task 4: vertical swipe. Up multiplies the box scale by 1.2,
  /// down divides it by 1.2, always staying within 0.5 to 3.0.
  void verticalSwipe(bool up) {
    final next = up ? boxScale * 1.2 : boxScale / 1.2;
    boxScale = next.clamp(minScale, maxScale).toDouble();
    lastGesture = up ? 'Swipe up' : 'Swipe down';
    notifyListeners();
  }
}

/// One shared instance used by both screens.
final AppState appState = AppState();
