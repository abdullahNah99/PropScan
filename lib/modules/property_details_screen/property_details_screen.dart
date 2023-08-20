import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/properties_screen/widgets/row_details.dart';

import 'package:untitled/modules/property_details_screen/cubit/property_details_cubit.dart';
import 'package:untitled/modules/property_details_screen/widget/coustom_image_slider.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/widgets/custome_progress_indicator.dart';

class PropertyDetailsView extends StatelessWidget {
  static const route = 'PropertyDetailsView';
  const PropertyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int propertyID = args['propertyID'];

    return BlocProvider(
      create: (context) =>
          PropertyDetailsCubit()..getPropertyDetails(propertyID: propertyID),
      child: Scaffold(
        appBar: AppBar(),
        body: PropertyDetailsBody(propertyID: propertyID),
      ),
    );
  }
}

class PropertyDetailsBody extends StatelessWidget {
  final int propertyID;
  const PropertyDetailsBody({
    super.key,
    required this.propertyID,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsSuccess) {
          BlocProvider.of<PropertyDetailsCubit>(context).propertyDetails =
              state.properties;
        } else if (state is PropertyDetailsFailure) {
          return Center(
            child: SizedBox(
              width: 300.w,
              height: 150.h,
              child: Card(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Center(
                        child: Text(
                      'Network ُrror',
                      style: TextStyle(fontSize: 30),
                    )),
                    const Center(
                        child: Text(
                      'Click to retry',
                      style: TextStyle(fontSize: 20),
                    )),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<PropertyDetailsCubit>(context)
                            .getPropertyDetails(propertyID: propertyID);
                      },
                      child: const Icon(
                        Icons.refresh_rounded,
                        size: 60,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is PropertyDetailsLoading) {
          return const CustomeProgressIndicator();
        }
        PropertyDetailsModel propertyDetails =
            BlocProvider.of<PropertyDetailsCubit>(context).propertyDetails
                as PropertyDetailsModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                ImageSlider(propertyDetails: propertyDetails),
                Divider(
                  endIndent: 30.w,
                  indent: 30.w,
                  thickness: 2,
                  color: AppColors.defaultColor,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        children: [
                          IconText(
                            icon: Icons.abc,
                            text: propertyDetails.price.toString(),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          IconText(
                            icon: Icons.abc,
                            text: propertyDetails.space.toString(),
                          ),
                        ],
                      ),
                      IconText(
                        icon: Icons.abc,
                        text: propertyDetails.type.toString(),
                      ),
                      Row(
                        children: [
                          IconText(
                            icon: Icons.abc,
                            text: propertyDetails.governorate.toString(),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          IconText(
                            icon: Icons.abc,
                            text: propertyDetails.region.toString(),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconText(
                                icon: Icons.abc,
                                text: propertyDetails.houseModel!.numberOfRooms
                                    .toString()),
                            IconText(
                                icon: Icons.abc,
                                text: propertyDetails
                                    .houseModel!.numberOfBathrooms
                                    .toString()),
                            IconText(
                                icon: Icons.abc,
                                text: propertyDetails
                                    .houseModel!.numberOfBalcony
                                    .toString()),
                          ],
                        ),
                        IconText(
                          icon: Icons.abc,
                          text:
                              propertyDetails.houseModel!.direction.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const IconText(icon: Icons.abc, text: 'Description'),
                        Text(
                          propertyDetails.houseModel!.description,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30.sp,
          color: Colors.green,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
