import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/enums/notify_user_enum.dart';
import 'package:lux_estate/core/theme/app_colors.dart';

OverlayEntry? _activeSnackBar;
void notifyUser(
  BuildContext context, {
  required String message,
  required String title,
  NotifyUserType type = NotifyUserType.info,
}) {
  // 1. Remove the existing snackbar if one is already showing
  _activeSnackBar?.remove();
  _activeSnackBar = null;

  final overlay = Overlay.of(context);
  final isRtl = Directionality.of(context) == TextDirection.rtl;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _TopSnackBarWidget(
      title: title,
      onDismiss: () {
        // Only remove if it's still the "active" one
        if (_activeSnackBar == overlayEntry) {
          overlayEntry.remove();
          _activeSnackBar = null;
        }
      },
      message: message,
      isRtl: isRtl,
      type: type,
    ),
  );

  _activeSnackBar = overlayEntry;
  overlay.insert(overlayEntry);
}

class _TopSnackBarWidget extends StatefulWidget {
  final VoidCallback onDismiss;
  final bool isRtl;
  final String message;
  final String title;
  final NotifyUserType type;

  _TopSnackBarWidget({
    required this.onDismiss,
    required this.isRtl,
    required this.message,
    required this.title,
    required this.type,
  });

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late final Color backgroundColor;
  late final Color borderColor;
  late final IconData icon;
  late final Color iconColor;
  late final Color textColor;
  late final Color titleColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    switch (widget.type) {
      case NotifyUserType.success:
        // You can customize the appearance based on the type
        backgroundColor = AppColors.primary;
        borderColor = AppColors.success;
        icon = Icons.check;
        iconColor = AppColors.success;
        textColor = Colors.white;
        titleColor = AppColors.success;

        break;
      case NotifyUserType.error:
        // Customize for error
        backgroundColor = AppColors.primary;
        borderColor = AppColors.error;
        icon = Icons.error;
        iconColor = AppColors.error;
        textColor = Colors.white;
        titleColor = AppColors.error;

        break;
      case NotifyUserType.warning:
        // Customize for warning
        backgroundColor = AppColors.primary;
        borderColor = AppColors.warning;
        icon = Icons.warning;
        iconColor = AppColors.warning;
        textColor = Colors.white;
        titleColor = AppColors.warning;

        break;
      case NotifyUserType.info:
        // Customize for info
        backgroundColor = AppColors.primary;
        borderColor = AppColors.info;
        icon = Icons.info;
        iconColor = AppColors.info;
        textColor = Colors.white;
        titleColor = AppColors.info;

        break;
    }

    // Determines slide direction: Start from off-screen (1.0 or -1.0) to zero
    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.isRtl ? -1.0 : 1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // CRITICAL: Check if the widget is still in the tree
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() async {
    // Check mounted again because the user might have clicked 'X'
    // exactly when the timer fired.
    if (!mounted) return;

    try {
      await _controller.reverse();
      if (mounted) {
        widget.onDismiss();
      }
    } catch (e) {
      // Safely handle cases where the controller might be gone
      debugPrint("Snackbar dismiss error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 10.w,
      right: 10.w,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: AppColors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: backgroundColor, // Deep Blue
              borderRadius: BorderRadius.circular(20),
              border: Border(
                left: widget.isRtl
                    ? BorderSide.none
                    : BorderSide(color: borderColor, width: 6.w),
                right: widget.isRtl
                    ? BorderSide(color: borderColor, width: 6.w)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.transparent,
                  radius: 18,
                  child: Icon(icon, color: iconColor, size: 20.r),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        widget.message,
                        style: TextStyle(color: textColor, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.grey, size: 20.r),
                  onPressed: _dismiss,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
