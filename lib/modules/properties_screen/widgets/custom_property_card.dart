import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/properties_screen/widgets/row_details.dart';
import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';

class PropertyCard extends StatelessWidget {
  final int index;
  final PropertiesCubit propertiesCubit;
  final PropertyModel properties;

  const PropertyCard({
    super.key,
    required this.index,
    required this.propertiesCubit,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await propertiesCubit.getPropertyChatUser(localUserID: 7);
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
                    image: DecorationImage(
                      image: NetworkImage(
                        properties.images.isEmpty
                            ? ''
                            : "http://192.168.43.37:8000/${properties.images[0]["image"]}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  top: 5.h,
                  child: TextButton(
                    onPressed: () {
                      propertiesCubit.changeIsFoveate(properties: properties);
                      log('${properties.isFoveate}');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.grey[50],
                      ),
                      child: Center(
                        child: Icon(
                          properties.isFoveate == true
                              ? Icons.favorite_rounded
                              : Icons.favorite_border,
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
            RowDetails(
              icon: Icons.location_on_outlined,
              text: "${properties.governorate}-${properties.region}",
            ),
          ],
        ),
      ),
    );
  }
}
