import 'package:flutter/material.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/async/error_display.dart';

class AsyncViewBuilder<T> extends StatelessWidget {
  final AsyncState<T> state;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? onEmpty; // Optional widget for empty data states

  final VoidCallback onRetry;

  const AsyncViewBuilder({
    required this.state,
    required this.onSuccess,
    required this.onRetry,
    this.loadingWidget,
    this.onEmpty,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return ErrorDisplay(
        message: state.errorMessage!,
        onRetry: onRetry, // The 'Retry' behavior is now identical everywhere
      );
    }

    if ((state.data as List).isEmpty) {
      return onEmpty ?? const Center(child: Text('No data available.'));
    } else if (state.data == null) {
      return onEmpty ?? const Center(child: Text('No data available.'));
    } else {
      return onSuccess(state.data as T);
    }
  }
}
