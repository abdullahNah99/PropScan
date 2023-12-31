import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/widgets/property_text_field.dart';
import 'package:untitled/modules/chat_screen.dart/chat_screen.dart';
import 'package:untitled/modules/google_map_screen/google_map_screen.dart';
import 'package:untitled/modules/property_details_screen/cubit/property_details_cubit.dart';
import 'package:untitled/modules/property_details_screen/widget/coustom_image_slider.dart';
import 'package:untitled/modules/property_details_screen/widget/daily_rent_grid_view.dart';
import 'package:untitled/shared/functions/custom_dialog.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/utils/app_assets.dart';
import 'package:untitled/shared/widgets/custome_image.dart';
import 'package:untitled/shared/widgets/custome_progress_indicator.dart';

import '../../shared/functions/custom_snack_bar.dart';

class PropertyDetailsView extends StatelessWidget {
  static const route = 'PropertyDetailsView';
  const PropertyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int propertyID = args['propertyID'];
    String type = args['type'];
    int space = args['space'];

    return BlocProvider(
      create: (context) {
        if (space.toString()[0] == '3') {
          return PropertyDetailsCubit()
            ..getPropertyDetails(propertyID: propertyID)
            ..getReservationDates(propertyID: propertyID);
        } else {
          return PropertyDetailsCubit()
            ..getPropertyDetails(propertyID: propertyID);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(type),
        ),
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
    PropertyDetailsCubit propertyDetailsCubit =
        BlocProvider.of<PropertyDetailsCubit>(context);
    return BlocConsumer<PropertyDetailsCubit, PropertyDetailsState>(
      listener: (context, state) {
        if (state is ReservationFailure) {
          Navigator.pop(context);
          CustomeSnackBar.showErrorSnackBar(context, msg: state.errorMessage);
        } else if (state is ReservationSuccess) {
          Navigator.pop(context);
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Reservation Added Successfully',
            color: Colors.green,
          );
        } else if (state is StoreReportSuccess) {
          Navigator.pop(context);
          CustomeSnackBar.showSnackBar(
            context,
            msg: state.messageModel.message,
            color: Colors.green,
          );
        } else if (state is StoreReportFailure) {
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Network Error',
            color: Colors.red,
          );
        } else if (state is GetPropertyChatUserSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatView(user: state.chatUser),
            ),
          );
        }
      },
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

        PropertyDetailsModel? propertyDetails =
            BlocProvider.of<PropertyDetailsCubit>(context).propertyDetails;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(propertyDetails: propertyDetails!),
                AllButtons(
                  propertyDetails: propertyDetails,
                  propertyDetailsCubit: propertyDetailsCubit,
                ),
                GeneralInformationCard(
                  propertyDetails: propertyDetails,
                ),
                if (propertyDetails.houseModel != null ||
                    propertyDetails.farmModel != null)
                  PrivateInformationCard(
                    propertyDetails: propertyDetails,
                  ),
                LocationInformation(propertyDetails: propertyDetails),
                DescriptionCard(propertyDetails: propertyDetails)
              ],
            ),
          ),
        );
      },
    );
  }
}

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({
    super.key,
    required this.propertyDetails,
  });

  final PropertyDetailsModel propertyDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  : propertyDetails.type == 'Farm'
                      ? propertyDetails.farmModel!.description
                      : propertyDetails.marketModel!.description,
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationInformation extends StatelessWidget {
  const LocationInformation({
    super.key,
    required this.propertyDetails,
  });

  final PropertyDetailsModel propertyDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            //  Stack(
            //   children: [
            // SizedBox(
            //   width: double.infinity,
            //   height: 300.h,
            //   child: GoogleMapViewBody(
            //     select: false,
            //     locations: const [],
            //     lat: propertyDetails.x,
            //     lon: propertyDetails.y,
            //   ),
            // ),
            Row(
          children: [
            Text(
              'Location',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(175.w, 50.h),
                  backgroundColor: AppColors.defaultColor,
                ),
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
                child: Text(
                  'Go to map',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20.sp, letterSpacing: 2),
                )),
          ],
        )
        //   ],
        // ),
        );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.propertyDetails,
  });

  final PropertyDetailsModel propertyDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        ImageSlider(propertyDetails: propertyDetails),
        Divider(
          endIndent: 30.w,
          indent: 30.w,
          thickness: 1,
          color: AppColors.defaultColor,
        ),
        Text(
          propertyDetails.space.toString()[0] == '1'
              ? 'For Sale'
              : propertyDetails.space.toString()[0] == '2'
                  ? 'For Rent'
                  : 'Daily Rent',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.defaultColor,
            letterSpacing: 2,
          ),
        ),
        Divider(
          endIndent: 30.w,
          indent: 30.w,
          thickness: 1,
          color: AppColors.defaultColor,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

class PrivateInformationCard extends StatelessWidget {
  const PrivateInformationCard({
    super.key,
    required this.propertyDetails,
  });

  final PropertyDetailsModel propertyDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      ? propertyDetails.houseModel!.numberOfRooms.toString()
                      : propertyDetails.farmModel!.numberOfRooms.toString(),
                ),
                IconText(
                  image: propertyDetails.type == 'House'
                      ? AppAssets.bathtub
                      : AppAssets.pool,
                  text: propertyDetails.type == 'House'
                      ? propertyDetails.houseModel!.numberOfBathrooms.toString()
                      : propertyDetails.farmModel!.numberOfPools.toString(),
                ),
                if (propertyDetails.houseModel != null)
                  IconText(
                    image: AppAssets.couple,
                    text:
                        propertyDetails.houseModel!.numberOfBalcony.toString(),
                  ),
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            if (propertyDetails.houseModel != null)
              IconText(
                image: AppAssets.direction,
                text: propertyDetails.houseModel!.direction.toString(),
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
    );
  }
}

class GeneralInformationCard extends StatelessWidget {
  const GeneralInformationCard({
    super.key,
    required this.propertyDetails,
  });

  final PropertyDetailsModel propertyDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          IconText(
            image: AppAssets.price,
            text: "Price : ${propertyDetails.price.toString()}",
          ),
          SizedBox(
            height: 10.w,
          ),
          IconText(
              image: AppAssets.space,
              text: "Space : ${propertyDetails.space.toString().substring(
                    1,
                  )}"),
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
                text:
                    "${propertyDetails.governorate.toString()}-${propertyDetails.region.toString()}",
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class AllButtons extends StatelessWidget {
  const AllButtons({
    super.key,
    required this.propertyDetails,
    required this.propertyDetailsCubit,
  });

  final PropertyDetailsModel propertyDetails;
  final PropertyDetailsCubit propertyDetailsCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(0, 45.h),
                  ),
                  onPressed: () {
                    // log(propertyDetails.userID.toString());
                    propertyDetailsCubit.getPropertyChatUser(
                      localUserID: propertyDetails.userID,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      Text(
                        'Start a chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: Size(0, 45.h),
                  ),
                  onPressed: () {
                    // launchUrl(Uri.parse("tel://${phoneNum}"));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                      Text(
                        'Make a call',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    fixedSize: Size(0, 45.h),
                  ),
                  onPressed: () {
                    propertyDetailsCubit.descriptionReport = '';
                    for (var element in propertyDetailsCubit.reports) {
                      element.isReport = false;
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: ContentDialog(
                              propertyDetailsCubit: propertyDetailsCubit,
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (propertyDetailsCubit.descriptionReport !=
                                    '') {
                                  propertyDetailsCubit.storeReport(
                                      propertyID: propertyDetails.id,
                                      description: propertyDetailsCubit
                                          .descriptionReport);
                                } else {
                                  // CustomeSnackBar.showSnackBar(
                                  //   context,
                                  //   msg:
                                  //       'Please choose the reason for submitting the report',
                                  //   color: Colors.orange,
                                  // );
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomeImage(
                        image: AppAssets.cancel,
                        width: 15.w,
                        height: 15.h,
                        margin: EdgeInsets.only(right: 10.w),
                      ),
                      Text(
                        'Report',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (propertyDetails.space.toString()[0] == '3')
                SizedBox(
                  width: 10.w,
                ),
              if (propertyDetails.space.toString()[0] == '3')
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.defaultColor,
                      fixedSize: Size(0, 45.h),
                    ),
                    onPressed: () {
                      propertyDetailsCubit.getDailyRentDates();
                      CustomDialog.showDailyRentDialog(
                        context,
                        propertyDetailsCubit: propertyDetailsCubit,
                        dailyRentGrid: DailyRentGrid(
                          propertyDetailsCubit: propertyDetailsCubit,
                        ),
                      );
                    },
                    child: Text(
                      'Daily Rent',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

class ContentDialog extends StatefulWidget {
  const ContentDialog({super.key, required this.propertyDetailsCubit});
  final PropertyDetailsCubit propertyDetailsCubit;

  @override
  State<ContentDialog> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: List.generate(widget.propertyDetailsCubit.reports.length,
                (index) {
              // log(widget.propertyDetailsCubit.reports[index].isReport.toString());
              return Row(
                children: [
                  Text(widget.propertyDetailsCubit.reports[index].report),
                  const Spacer(),
                  Checkbox(
                    value: widget.propertyDetailsCubit.reports[index].isReport,
                    onChanged: (value) {
                      widget.propertyDetailsCubit.changeChecked(
                          widget.propertyDetailsCubit.reports[index],
                          index,
                          value!);
                      setState(() {});
                    },
                  ),
                ],
              );
            }),
          ),
          Text(
            'Other',
            style: TextStyle(
              color: AppColors.color2,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Center(
            child: PropertyTextField(
              width: 250.w,
              maxLines: 3,
              // hintText: 'Description',
              keyboardType: TextInputType.multiline,
              onChanged: (p0) {
                widget.propertyDetailsCubit.descriptionReport = p0;
                log(widget.propertyDetailsCubit.descriptionReport);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String image;
  final String text;
  final String? text1;
  const IconText(
      {super.key, required this.image, required this.text, this.text1});

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   text1 ?? '',
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
