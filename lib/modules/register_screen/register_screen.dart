import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/login_screen/login_screen.dart';
import 'package:untitled/modules/register_screen/cubit/register_cubit.dart';
import 'package:untitled/modules/register_screen/cubit/register_states.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import 'package:untitled/shared/widgets/custome_button.dart';
import 'package:untitled/shared/widgets/custome_progress_indicator.dart';

import '../../shared/styles/app_colors.dart';
import '../../shared/utils/app_assets.dart';
import '../../shared/widgets/custome_image.dart';
import '../../shared/widgets/custome_text_field.dart';

class RegisterView extends StatelessWidget {
  static const route = 'RegisterView';
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          body: RegisterViewBody(),
        ),
      ),
    );
  }
}

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const CustomeProgressIndicator();
        } else if (state is RegisterSuccess) {
          return const LoginView();
        } else {
          return _Body(
            registerCubit: BlocProvider.of<RegisterCubit>(context),
          );
        }
      },
      listener: (context, state) {
        if (state is RegisterFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final RegisterCubit registerCubit;
  const _Body({required this.registerCubit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: registerCubit.formKey,
        child: Column(
          children: [
            SizedBox(
              width: 500.w,
              height: 95.w,
            ),
            const CustomeImage(image: AppAssets.logo),
            SizedBox(height: 20.h),
            Text(
              'Create Your Account',
              style: TextStyle(
                color: AppColors.defaultColor,
                fontSize: 27.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Please Enter Your Info To Get Started',
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 60.h),
            CustomeTextField(
              labelText: 'Name',
              suffixIcon: const Icon(
                Icons.account_circle,
                color: AppColors.defaultColor,
                size: 27,
              ),
              onChanged: (value) => registerCubit.name = value,
            ),
            SizedBox(height: 20.h),
            CustomeTextField(
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(
                Icons.email,
                color: AppColors.defaultColor,
                size: 27,
              ),
              labelText: 'Email',
              onChanged: (value) => registerCubit.email = value,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'required';
                } else {
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.toString())) {
                    return "Please enter a valid email address";
                  }
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomeTextField(
              iconData: Icons.lock,
              labelText: 'Password',
              obscureText: true,
              suffixIcon: const Icon(
                Icons.password,
                color: AppColors.defaultColor,
                size: 27,
              ),
              onChanged: (value) => registerCubit.password = value,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'required';
                } else if (value!.length < 9) {
                  return 'Password must be at least 9 character';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomeTextField(
              labelText: 'Confirm Password',
              obscureText: true,
              suffixIcon: const Icon(
                Icons.password,
                color: AppColors.defaultColor,
                size: 27,
              ),
              onChanged: (value) => registerCubit.confirmPassword = value,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'required';
                } else if (value != registerCubit.password) {
                  return "Passwords don't match";
                }
                return null;
              },
            ),
            SizedBox(height: 60.h),
            CustomeButton(
              text: 'Register',
              onPressed: () async {
                if (registerCubit.formKey.currentState!.validate()) {
                  await registerCubit.register();
                }
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
