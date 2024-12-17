import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Modified version of https://github.com/spporan/FlutterOverlayLoader/blob/master/lib/flutter_overlay_loader.dart

class Loader extends StatelessWidget {
  static OverlayEntry? _currentLoader;

  const Loader._(this._progressIndicator, this._themeData);

  final Widget? _progressIndicator;
  final ThemeData? _themeData;
  static OverlayState? _overlayState;

  static bool get isLoading => _currentLoader != null;

  static void show(
    BuildContext context, {
    Widget? progressIndicator,
    ThemeData? themeData,
    Color? overlayColor,
  }) {
    _overlayState = Overlay.of(context);
    if (_currentLoader == null) {
      _currentLoader = OverlayEntry(
        builder: (context) => Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                color: overlayColor ?? const Color(0x99ffffff),
              ),
            ),
            Center(
              child: Loader._(
                progressIndicator,
                themeData,
              ),
            ),
          ],
        ),
      );
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final loader = _currentLoader;
          if (loader == null) return;
          _overlayState?.insertAll([loader]);
        });
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
      }
    }
  }

  static void hide() {
    final loader = _currentLoader;
    if (loader != null) {
      try {
        loader.remove();
      } catch (e) {
        if (kDebugMode) print(e.toString());
      } finally {
        _currentLoader = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _progressIndicator ?? const CircularProgressIndicator(),
    );
  }
}
