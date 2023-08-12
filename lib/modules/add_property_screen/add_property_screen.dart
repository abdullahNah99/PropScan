import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_governorates_button.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_regions_button.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import '../../shared/functions/custom_snack_bar.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/services/auth/logout_service.dart';
import '../../shared/styles/app_colors.dart';
import '../../shared/widgets/custome_button.dart';
import '../../shared/widgets/custome_progress_indicator.dart';
import '../google_map_screen/google_map_screen.dart';
import '../login_screen/login_screen.dart';
import 'cubit/add_property_cubit.dart';
import 'cubit/add_property_states.dart';

class AddPropertyView extends StatelessWidget {
  static const route = 'AddPropertyView';
  const AddPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPropertyCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.defaultColor,
            centerTitle: true,
            title: TextButton(
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: () async {
                await FirebaseAPIs.auth.signOut().then(
                  (value) async {
                    (await LogOutService.logout(
                      token: await CacheHelper.getData(key: 'Token'),
                    ))
                        .fold(
                      (failure) {
                        CustomeSnackBar.showSnackBar(
                          context,
                          msg: 'Something Went Wrong, Please Try Again',
                          color: Colors.red,
                        );
                      },
                      (success) async {
                        await CacheHelper.deletData(key: 'Token');
                        // ignore: use_build_context_synchronously
                        Navigator.popAndPushNamed(context, LoginView.route);
                      },
                    );
                  },
                );
              },
              child: const Text(
                'LogOut',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectGovernoratesButton(addPropertyCubit: addPropertyCubit),
          SizedBox(height: 20.h),
          SelectRegionsButton(addPropertyCubit: addPropertyCubit),
          SizedBox(height: 20.h),
          CustomeButton(
            text: 'Continue',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GoogleMapView(
                      select: true,
                      lat: addPropertyCubit.selectedRegion != null
                          ? addPropertyCubit.selectedRegion!.x
                          : null,
                      lon: addPropertyCubit.selectedRegion != null
                          ? addPropertyCubit.selectedRegion!.y
                          : null,
                      locations: const [],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
