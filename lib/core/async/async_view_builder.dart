import 'package:flutter/material.dart';
import 'package:lux_estate/core/async/async_state.dart';
import 'package:lux_estate/core/async/error_display.dart';

class AsyncViewBuilder<T> extends StatelessWidget {
  final AsyncState<T> state;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? onEmpty;
  final Widget? initialWidget; // Fixed typo from 'initalWidget'
  final VoidCallback onRetry;

  const AsyncViewBuilder({
    required this.state,
    required this.onSuccess,
    required this.onRetry,
    this.loadingWidget,
    this.initialWidget,
    this.onEmpty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Using the power of Dart 3 pattern matching
    return switch (state) {
      DataInitial() => initialWidget ?? const SizedBox.shrink(),

      DataLoading() =>
        loadingWidget ?? const Center(child: CircularProgressIndicator()),

      DataFailed(errorMessage: var message) => ErrorDisplay(
        message: message ?? "An unexpected error occurred",
        onRetry: onRetry,
      ),

      DataSuccess(data: var data) => _buildSuccess(data),

      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildSuccess(T? data) {
    if (data == null) return onEmpty ?? const SizedBox.shrink();

    // Shadowing عشان الـ Type Promotion
    final T nonNullData = data;

    if (nonNullData is Iterable && nonNullData.isEmpty) {
      return onEmpty ?? const SizedBox.shrink();
    }

    return onSuccess(nonNullData);
  }
}
