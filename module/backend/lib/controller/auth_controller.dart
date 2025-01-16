import 'dart:async';

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';

class TokenActivityController extends InheritedWidget {
  final bool isActive;
  final DateTime lastActivity;
  final Function(DateTime) onActivity;

  const TokenActivityController({
    super.key,
    required super.child,
    required this.isActive,
    required this.lastActivity,
    required this.onActivity,
  });

  static TokenActivityController of(BuildContext context) {
    final maybe = maybeOf(context);
    assert(maybe != null, 'TokenActivityController not found in context');
    return maybe!;
  }

  static TokenActivityController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TokenActivityController>();
  }

  @override
  bool updateShouldNotify(TokenActivityController oldWidget) {
    return isActive != oldWidget.isActive ||
        lastActivity != oldWidget.lastActivity ||
        onActivity != oldWidget.onActivity;
  }
}

class TokenActivityStateProvider extends StatefulWidget {
  final Widget child;
  final Duration inactiveTimeout;
  //
  const TokenActivityStateProvider({
    super.key,
    required this.child,
    this.inactiveTimeout = const Duration(minutes: 30),
  });

  @override
  State<TokenActivityStateProvider> createState() =>
      _TokenActivityStateProviderState();
}

class _TokenActivityStateProviderState
    extends State<TokenActivityStateProvider> {
  bool _isActive = true;
  DateTime _lastActivity = DateTime.now();
  final ServiceSecureStorage _storage = ServiceSecureStorage();
  Timer? _activityTimer;

  @override
  void initState() {
    super.initState();
    _startActivityTimer();
    _checkTokenActivity();
  }

  void _startActivityTimer() {
    _activityTimer?.cancel();
    _activityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final difference = DateTime.now().difference(_lastActivity);
      if (difference >= widget.inactiveTimeout && _isActive) {
        setState(() => _isActive = false);
        _handleInactive();
      }
    });
  }

  Future<void> _checkTokenActivity() async {
    await _storage.init();
    final token = await _storage.read<String>(BearerTokenKey);
    if (token == null) setState(() => _isActive = true);
  }

  void _updateActivity(DateTime? time) {
    _lastActivity = time ?? DateTime.now();
    _isActive = true;
    setState(() {});
  }

  Future<void> _handleInactive() async {
    await _storage.dispose();
  }

  @override
  void dispose() {
    _activityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _updateActivity(DateTime.now()),
      onPanDown: (_) => _updateActivity(DateTime.now()),
      child: TokenActivityController(
        isActive: _isActive,
        lastActivity: _lastActivity,
        onActivity: _updateActivity,
        child: widget.child,
      ),
    );
  }
}
