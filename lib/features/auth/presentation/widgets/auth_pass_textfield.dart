import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({super.key, this.label, this.controller});
  final String? label;
  final TextEditingController? controller;
  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label?.toUpperCase() ?? 'PASSWORD',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color:
                    AppColors.grey, //Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              'Forgot?',
              style: TextStyle(
                color:
                    AppColors.black, //Theme.of(context).colorScheme.primary),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        AppSizes.spaceXS.verticalSpace,
        TextFormField(
          controller: widget.controller,
          obscureText: obscure,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.grey, //Theme.of(context).colorScheme.secondary,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
