// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/modules/home/cubit/home_cubit.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit(),
//       child: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
//           return Scaffold(
//             bottomNavigationBar: BottomNavigationBar(
//               items: homeCubit.items,
//               onTap: (index) {
//                 log(index.toString());
//                 homeCubit.changeIndex(index);
//               },
//               currentIndex: homeCubit.index,
//             ),
//             body: homeCubit.widget[homeCubit.index],
//           );
//         },
//       ),
//     );
//   }
// }
