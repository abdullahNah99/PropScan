import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_states.dart';
import 'package:untitled/modules/properties_screen/widgets/custom_drawer.dart';
import 'package:untitled/shared/models/user_model.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import '../../shared/styles/app_colors.dart';

class PropertiesView extends StatefulWidget {
  static const route = 'PropertiesView';
  final UserModel? userModel;
  const PropertiesView({super.key, this.userModel});

  @override
  State<PropertiesView> createState() => _PropertiesViewState();
}

class _PropertiesViewState extends State<PropertiesView> {
  @override
  void initState() {
    super.initState();
    FirebaseAPIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertiesCubit(),
      child: BlocBuilder<PropertiesCubit, PropertiesStates>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.defaultColor,
                title: const Text('PropScan'),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: const AssetImage(
                        'assets/images/a8.png',
                      ),
                      height: 50.h,
                    ),
                  ),
                ],
              ),
              body: const PropertiesViewBody(),
              drawer: widget.userModel != null
                  ? CustomDrawer.getCustomDrawer(
                      context,
                      propertiesCubit:
                          BlocProvider.of<PropertiesCubit>(context),
                      scaffoldKey:
                          BlocProvider.of<PropertiesCubit>(context).scaffoldKey,
                      userModel: widget.userModel!,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class PropertiesViewBody extends StatelessWidget {
  const PropertiesViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      header: const Header(),
      itemBuilder: (context, index) {
        return PropertyCard(
          index: index,
          key: Key(index.toString()),
        );
      },
      // scrollDirection: Axis.horizontal,
      // reverse: true,
      footer: const Footer(),
      itemCount: 10,
      padding: const EdgeInsets.all(16.0),
      onReorder: (int oldIndex, int newIndex) {
        log(oldIndex.toString());
        log(newIndex.toString());
      },
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 150.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            image: const DecorationImage(
              image: AssetImage('assets/images/a8.png'),
              // fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.maps_home_work_outlined,
            size: 120,
            color: AppColors.defaultColor,
          ),
        ),
      ],
    );
  }
}

class PropertyCard extends StatelessWidget {
  final int index;

  const PropertyCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // StoreHouseModel s = StoreHouseModel(
        //   numOfRooms: 5,
        //   numOfBathrooms: 2,
        //   numOfBalcony: 1,
        //   direction: 'North',
        //   description: 'Testooo',
        //   price: 1000000,
        //   space: 100,
        //   regionID: 1,
        //   propertyTypeID: 1,
        //   x: 100.12,
        //   y: 110.11,
        // );
        // await StorePropertyService.storeProperty(
        //   storePropertyModel: s,
        // );
      },
      child: Card(
        key: key,
        elevation: 8,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/a2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  top: 5.h,
                  child: TextButton(
                    onPressed: () {
                      log('mmmm');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.grey[50],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const RowDetails(
              icon: Icons.phone,
              text: '0934487928',
            ),
            const RowDetails(
              icon: Icons.location_on_outlined,
              text: 'xxxxxxxxxxxx',
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            enlargeFactor: 0.3,
          ),
          items: [
            'assets/images/a1.jpg',
            'assets/images/a2.jpg',
            'assets/images/a3.jpg',
            'assets/images/a4.jpg',
            'assets/images/a5.jpg',
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: AssetImage(i),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Divider(
          endIndent: 30.w,
          indent: 30.w,
          thickness: 2,
          color: AppColors.defaultColor,
        )
      ],
    );
  }
}

class RowDetails extends StatelessWidget {
  final IconData icon;
  final String text;
  const RowDetails({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
