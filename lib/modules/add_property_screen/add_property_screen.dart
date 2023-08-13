import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_governorates_button.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_regions_button.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_type_buttons.dart';
import 'package:untitled/modules/add_property_screen/widgets/selected_images_list.dart';
import '../../shared/constant/const.dart';
import '../../shared/functions/custom_snack_bar.dart';
import '../../shared/styles/app_colors.dart';
import '../../shared/widgets/custome_progress_indicator.dart';
import 'cubit/add_property_cubit.dart';
import 'cubit/add_property_states.dart';

class AddPropertyView extends StatelessWidget {
  static const route = 'AddPropertyView';
  const AddPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    log('scaffolddddddd');
    return BlocProvider(
      create: (context) => AddPropertyCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.defaultColor,
            centerTitle: true,
            // title: TextButton(
            //   style: TextButton.styleFrom(
            //     side: const BorderSide(color: Colors.white),
            //   ),
            //   onPressed: () async {
            //     await FirebaseAPIs.auth.signOut().then(
            //       (value) async {
            //         (await LogOutService.logout(
            //           token: await CacheHelper.getData(key: 'Token'),
            //         ))
            //             .fold(
            //           (failure) {
            //             CustomeSnackBar.showSnackBar(
            //               context,
            //               msg: 'Something Went Wrong, Please Try Again',
            //               color: Colors.red,
            //             );
            //           },
            //           (success) async {
            //             await CacheHelper.deletData(key: 'Token');
            //             // ignore: use_build_context_synchronously
            //             Navigator.popAndPushNamed(context, LoginView.route);
            //           },
            //         );
            //       },
            //     );
            //   },
            //   child: const Text(
            //     'LogOut',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
          ),
          body: const AddPropertyViewBody(),
        ),
      ),
    );
  }
}

class AddPropertyViewBody extends StatelessWidget {
  const AddPropertyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    AddPropertyCubit addPropertyCubit =
        BlocProvider.of<AddPropertyCubit>(context);
    return BlocConsumer<AddPropertyCubit, AddPropertyStates>(
      listener: (context, state) {
        if (state is AddPropertyFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is AddPropertyLoading) {
          return const CustomeProgressIndicator();
        } else {
          return _AddPropertyBody(addPropertyCubit: addPropertyCubit);
        }
      },
    );
  }
}

class _AddPropertyBody extends StatelessWidget {
  final AddPropertyCubit addPropertyCubit;
  const _AddPropertyBody({required this.addPropertyCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyStates>(
      builder: (context, state) {
        AddPropertyCubit cubit = BlocProvider.of<AddPropertyCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SelectedImagesList(cubit: cubit),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  cubit.selectimage();
                },
                child: Text(
                  'Choose Images ',
                  style: TextStyle(color: HexColor(bp)),
                ),
              ),
              SizedBox(
                height: 75,
                child: SelectTypeButtons(cubit: cubit),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectGovernoratesButton(addPropertyCubit: addPropertyCubit),
                  SelectRegionsButton(addPropertyCubit: addPropertyCubit),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}











// Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SelectGovernoratesButton(addPropertyCubit: addPropertyCubit),
//           SizedBox(height: 20.h),
//           SelectRegionsButton(addPropertyCubit: addPropertyCubit),
//           SizedBox(height: 20.h),
//           CustomeButton(
//             text: 'Continue',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return GoogleMapView(
//                       select: true,
//                       lat: addPropertyCubit.selectedRegion != null
//                           ? addPropertyCubit.selectedRegion!.x
//                           : null,
//                       lon: addPropertyCubit.selectedRegion != null
//                           ? addPropertyCubit.selectedRegion!.y
//                           : null,
//                       locations: const [],
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );