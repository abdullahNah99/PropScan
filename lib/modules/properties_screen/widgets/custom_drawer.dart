import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/conversations_screen/conversations_screen.dart';
import 'package:untitled/modules/my_advertisements_screen/my_advertisements_screen.dart';
import 'package:untitled/modules/profile_screen/profile_screen.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/properties_screen/widgets/custom_drawer_button.dart';
import 'package:untitled/shared/models/user_model.dart';
import 'package:untitled/shared/styles/app_colors.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      width: 250.w,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.r),
              ),
              color: AppColors.color2,
            ),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Center(
                  child: CustomeImage(
                    height: 75.h,
                    width: 80.w,
                    image: AppAssets.logo,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Text(
                    userModel.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          CustomDrawerButton(
            text: 'Profile',
            icon: Icons.account_circle,
            onPressed: () {
              Navigator.pushNamed(context, ProfileView.route);
            },
          ),
          SizedBox(height: 15.h),
          CustomDrawerButton(
            text: 'Favorite',
            icon: Icons.favorite,
            onPressed: () {},
          ),
          SizedBox(height: 15.h),
          CustomDrawerButton(
            text: 'Conversations',
            icon: Icons.chat,
            onPressed: () {
              Navigator.pushNamed(context, ConversationsView.route);
            },
          ),
          SizedBox(height: 15.h),
          CustomDrawerButton(
            text: 'Advertisements',
            fontSize: 18.w,
            icon: FontAwesomeIcons.ad,
            onPressed: () {
              Navigator.pushNamed(context, MyAdvertisementsView.route,
                  arguments: {
                    'propertiesCubit': propertiesCubit,
                    'userModel': userModel,
                  });
            },
          ),
          SizedBox(height: 15.h),
          const Expanded(child: SizedBox(height: 10)),
          CustomDrawerButton(
            text: 'Logout',
            icon: Icons.logout,
            iconColor: Colors.red,
            onPressed: () async {
              await propertiesCubit.logOut(context);
            },
          ),
          const SizedBox(height: 20),
          SizedBox(height: 25.h),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
