import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({super.key, this.onPressed, required this.title});
  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            8.horizontalSpace,
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
