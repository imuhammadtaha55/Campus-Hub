import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/app_theme.dart';

/// Embedded HTTPS page. A WebView has no height of its own, so it is given a
/// bounded height (SizedBox) because it sits inside a scrolling ListView.
class WebPagePanel extends StatefulWidget {
  final String url;

  const WebPagePanel({super.key, this.url = 'https://flutter.dev/'});

  @override
  State<WebPagePanel> createState() => _WebPagePanelState();
}

class _WebPagePanelState extends State<WebPagePanel> {
  WebViewController? _controller;
  int _progress = 0;
  bool _failed = false;

  // webview_flutter has no Windows / Linux / Chrome implementation.
  bool get _supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);

  @override
  void initState() {
    super.initState();
    if (_supported) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) {
              if (!mounted) return;
              setState(() {
                _failed = false;
                _progress = 0;
              });
            },
            onProgress: (value) {
              if (mounted) setState(() => _progress = value);
            },
            onPageFinished: (_) {
              if (mounted) setState(() => _progress = 100);
            },
            onWebResourceError: (error) {
              // Only react to the main page failing (e.g. offline).
              if (mounted && error.isForMainFrame != false) {
                setState(() => _failed = true);
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  void _retry() {
    setState(() {
      _failed = false;
      _progress = 0;
    });
    _controller?.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null) {
      return const _PanelMessage(
        icon: Icons.phonelink_off,
        title: 'WebView is not available on this platform',
        text: 'webview_flutter works on Android, iOS and macOS. '
            'Run the app on an Android emulator or phone to see the page.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scroll inside the box to read the page; drag outside it to '
          'scroll the gallery.',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 360, // bounded height: required inside a ListView
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                WebViewWidget(
                  controller: controller,
                  // Lets the page scroll vertically even though it sits
                  // inside the gallery's ListView.
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                ),
                if (_progress < 100 && !_failed)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: _progress == 0 ? null : _progress / 100,
                    ),
                  ),
                if (_failed)
                  Positioned.fill(
                    child: _PanelMessage(
                      icon: Icons.wifi_off,
                      title: 'Page could not be loaded',
                      text: 'Check your internet connection and try again.',
                      onRetry: _retry,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PanelMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final VoidCallback? onRetry;

  const _PanelMessage({
    required this.icon,
    required this.title,
    required this.text,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.soft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: AppTheme.primary),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(text, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
