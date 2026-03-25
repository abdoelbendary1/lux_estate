import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lux_estate/core/theme/app_colors.dart';
import 'package:lux_estate/core/theme/app_sizes.dart';
import 'package:lux_estate/core/cubits/obsecure_password/obsecure_password_cubit.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.label,
    this.controller,
    required this.validator,
    this.focusNode,
    this.onFieldSubmitted,
  });
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
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
                fontSize: 14.sp,

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
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        AppSizes.spaceXS.verticalSpace,
        BlocBuilder<ObsecurePasswordCubit, ObsecurePasswordState>(
          builder: (context, state) {
            return TextFormField(
              onFieldSubmitted: widget.onFieldSubmitted,
              focusNode: widget.focusNode,
              validator: widget.validator,
              controller: widget.controller,
              obscureText: state is ObsecurePasswordInitial,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color:
                    AppColors.grey, //Theme.of(context).colorScheme.secondary,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    state is ObsecurePasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    context.read<ObsecurePasswordCubit>().toggleObsecure();
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
