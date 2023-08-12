import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/styles/app_colors.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class PasswordSuffixIcon extends StatelessWidget {
  const PasswordSuffixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

        return InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: () {
            loginCubit.changePasswordState();
          },
          child: Icon(
            loginCubit.icon,
            color: AppColors.defaultColor,
          ),
        );
      },
    );
  }
}
