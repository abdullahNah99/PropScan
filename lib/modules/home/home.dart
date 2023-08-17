import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/home/cubit/home_cubit.dart';
import 'package:untitled/shared/styles/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: BlocProvider.of<HomeCubit>(context).items,
              onTap: (index) {
                log(index.toString());
                BlocProvider.of<HomeCubit>(context).changeIndex(index);
              },
              currentIndex: BlocProvider.of<HomeCubit>(context).index,
            ),
            body: BlocProvider.of<HomeCubit>(context)
                .widget[BlocProvider.of<HomeCubit>(context).index],
          );
        },
      ),
    );
  }
}
