import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
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
              itemBuilder: (BuildContext context, int indexS) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Stack(
                              children: [
                                PhotoViewGallery.builder(
                                  backgroundDecoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.85)),
                                  pageController:
                                      PageController(initialPage: indexS),
                                  builder: (BuildContext context, int index) {
                                    return PhotoViewGalleryPageOptions(
                                      minScale:
                                          PhotoViewComputedScale.contained,
                                      maxScale:
                                          PhotoViewComputedScale.covered * 4,
                                      imageProvider: FileImage(
                                        File(cubit.selectedImagesList[index]),
                                      ),
                                      initialScale:
                                          PhotoViewComputedScale.contained,
                                    );
                                  },
                                  itemCount: cubit.selectedImagesList.length,
                                  loadingBuilder: (context, event) => Center(
                                    child: SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        value: event == null
                                            ? 0
                                            : event.cumulativeBytesLoaded /
                                                event.expectedTotalBytes!
                                                    .toInt(),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: CustomeFileImage(
                        filePath: cubit.selectedImagesList[indexS],
                      ),
                    ),
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
                            cubit.deleteImageFromList(imageIndex: indexS);
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
