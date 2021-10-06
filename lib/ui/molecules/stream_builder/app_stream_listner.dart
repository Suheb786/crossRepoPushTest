import 'dart:async';

import 'package:flutter/widgets.dart';

/// A convenience widget for listening to a stream without having
/// to create a [StatefulWidget] or canceling a [Stream] subscription.
/// If [child] is null, an empty [SizedBox] will be used.
class AppStreamListener<T> extends StatefulWidget {
  final Stream<T> stream;
  final ValueChanged<T>? onData;
  final ValueChanged<Object>? onError;
  final VoidCallback? onDone;
  final bool? cancelOnError;
  final Widget? child;

  const AppStreamListener({
    Key? key,
    required this.stream,
    this.onData,
    this.onError,
    this.onDone,
    this.cancelOnError,
    this.child,
  }) : super(key: key);

  @override
  _AppStreamListenerState<T> createState() => _AppStreamListenerState<T>();
}

class _AppStreamListenerState<T> extends State<AppStreamListener<T>> {
  StreamSubscription<T>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen(
      widget.onData,
      onError: widget.onError,
      onDone: widget.onDone,
      cancelOnError: widget.cancelOnError,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
