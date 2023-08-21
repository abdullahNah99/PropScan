import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/google_map_screen/google_map_screen.dart';

import 'package:untitled/modules/property_details_screen/cubit/property_details_cubit.dart';
import 'package:untitled/modules/property_details_screen/widget/coustom_image_slider.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/utils/app_assets.dart';
import 'package:untitled/shared/widgets/custome_image.dart';
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
                      'Network error',
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
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        children: [
                          IconText(
                            image: AppAssets.price,
                            text: propertyDetails.price.toString(),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          IconText(
                            image: AppAssets.space,
                            text: propertyDetails.space.toString(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      IconText(
                        image: propertyDetails.type == 'House'
                            ? AppAssets.home
                            : propertyDetails.type == 'Farm'
                                ? AppAssets.villa
                                : AppAssets.pofruitShop,
                        text: propertyDetails.type.toString(),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        children: [
                          IconText(
                            image: AppAssets.address,
                            text: propertyDetails.governorate.toString(),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          IconText(
                            image: AppAssets.address,
                            text: propertyDetails.region.toString(),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
                if (propertyDetails.houseModel != null ||
                    propertyDetails.farmModel != null)
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconText(
                                image: AppAssets.livingRoom,
                                text: propertyDetails.type == 'House'
                                    ? propertyDetails.houseModel!.numberOfRooms
                                        .toString()
                                    : propertyDetails.farmModel!.numberOfRooms
                                        .toString(),
                              ),
                              IconText(
                                image: propertyDetails.type == 'House'
                                    ? AppAssets.bathtub
                                    : AppAssets.pool,
                                text: propertyDetails.type == 'House'
                                    ? propertyDetails
                                        .houseModel!.numberOfBathrooms
                                        .toString()
                                    : propertyDetails.farmModel!.numberOfPools
                                        .toString(),
                              ),
                              if (propertyDetails.houseModel != null)
                                IconText(
                                  image: AppAssets.couple,
                                  text: propertyDetails
                                      .houseModel!.numberOfBalcony
                                      .toString(),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          if (propertyDetails.houseModel != null)
                            IconText(
                              image: AppAssets.direction,
                              text: propertyDetails.houseModel!.direction
                                  .toString(),
                            ),
                          if (propertyDetails.farmModel != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconText(
                                  image: propertyDetails.farmModel!.isGarden
                                      ? AppAssets.ok
                                      : AppAssets.cancel,
                                  text: 'Garden',
                                ),
                                IconText(
                                  image: propertyDetails.farmModel!.isBar
                                      ? AppAssets.ok
                                      : AppAssets.cancel,
                                  text: 'Bar',
                                ),
                                IconText(
                                  image: propertyDetails.farmModel!.isBabyPool
                                      ? AppAssets.ok
                                      : AppAssets.cancel,
                                  text: 'BabyPool',
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 300.h,
                        child: GoogleMapViewBody(
                          select: false,
                          locations: const [],
                          lat: propertyDetails.x,
                          lon: propertyDetails.y,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return GoogleMapViewBody(
                                  select: false,
                                  locations: const [],
                                  lat: propertyDetails.x,
                                  lon: propertyDetails.y,
                                );
                              },
                            ));
                          },
                          child: const Text('Go to map'))
                    ],
                  ),
                ),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const IconText(
                          image: AppAssets.newspaper,
                          text: 'Description',
                        ),
                        Text(
                          propertyDetails.type == 'House'
                              ? propertyDetails.houseModel!.description
                                  .substring(
                                  1,
                                )
                              : propertyDetails.type == 'Farm'
                                  ? propertyDetails.farmModel!.description
                                      .substring(
                                      1,
                                    )
                                  : propertyDetails.marketModel!.description
                                      .substring(
                                      1,
                                    ),
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
  final String image;
  final String text;
  const IconText({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomeImage(
          image: image,
          width: 25.w,
          height: 25.h,
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
