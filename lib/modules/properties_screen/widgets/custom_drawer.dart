import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/properties_screen/widgets/custom_drawer_button.dart';
import 'package:untitled/shared/models/user_model.dart';
import 'package:untitled/shared/utils/app_assets.dart';
import '../../../shared/widgets/custome_image.dart';

abstract class CustomDrawer {
  static Drawer getCustomDrawer(
    BuildContext context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    required PropertiesCubit propertiesCubit,
    required UserModel userModel,
  }) {
    return Drawer(
      width: 250.w,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Center(
            child: CustomeImage(
              height: 75.h,
              width: 80.w,
              image: AppAssets.logo,
              color: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: Text(
              userModel.name,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          CustomDrawerButton(
            text: 'Favorite',
            icon: Icons.favorite,
            onPressed: () {},
          ),
          SizedBox(height: 15.h),
          const Expanded(child: SizedBox(height: 10)),
          CustomDrawerButton(
            text: 'Logout',
            icon: Icons.logout,
            onPressed: () async {
              await propertiesCubit.logOut(context);
            },
          ),
          const SizedBox(height: 20),

          SizedBox(height: 25.h),
          // CustomDrawerButton(
          //   text: 'Consultations',
          //   icon: Icons.question_answer,
          //   onPressed: () {
          //     scaffoldKey.currentState!.closeDrawer();
          //     Navigator.pushNamed(
          //       context,
          //       ShowAllConsultationView.route,
          //     );
          //   },
          // ),
          // SizedBox(height: 15.h),
          // CustomDrawerButton(
          //   text: 'Favourite',
          //   icon: Icons.favorite_outlined,
          //   onPressed: () {
          //     scaffoldKey.currentState!.closeDrawer();
          //     Navigator.pushNamed(
          //       context,
          //       FavouriteView.route,
          //       arguments: patientModel,
          //     );
          //   },
          // ),
          // const Expanded(child: SizedBox()),
          // CustomDrawerButton(
          //   text: 'Log Out',
          //   icon: Icons.logout,
          //   iconColor: Colors.red,
          //   onPressed: () {
          //     scaffoldKey.currentState!.closeDrawer();
          //     homeCubit.logout(context);
          //   },
          // ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
