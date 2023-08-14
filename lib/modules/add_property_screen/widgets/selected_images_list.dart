import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/cubit/add_property_cubit.dart';
import 'package:untitled/shared/widgets/custome_image.dart';

class SelectedImagesList extends StatelessWidget {
  final AddPropertyCubit cubit;
  const SelectedImagesList({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: cubit.selectedImagesList.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.selectedImagesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    CustomeFileImage(filePath: cubit.selectedImagesList[index]),
                    Positioned(
                      left: 120.w,
                      top: 10.h,
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cubit.deleteImageFromList(imageIndex: index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Text(
                'Please Select Images',
                style: TextStyle(color: Colors.grey, fontSize: 30.sp),
              ),
            ),
    );
  }
}
