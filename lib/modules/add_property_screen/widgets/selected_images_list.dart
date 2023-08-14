import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/cubit/add_property_cubit.dart';
import 'package:untitled/shared/widgets/custome_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


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

//                 return InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return Container(
//                           child: PhotoViewGallery.builder(
//                             scrollPhysics: const BouncingScrollPhysics(),
//                             builder: (BuildContext context, int index) {
//                               return PhotoViewGalleryPageOptions(
//                                 imageProvider: FileImage(
//                                   File(cubit.selectedImagesList[index].path),
//                                 ),

//                                 initialScale:
//                                     PhotoViewComputedScale.contained * 0.8,
//                                 // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
//                               );
//                             },
//                             itemCount: cubit.selectedImagesList.length,
//                             loadingBuilder: (context, event) => Center(
//                               child: Container(
//                                 width: 20.0,
//                                 height: 20.0,
//                                 child: CircularProgressIndicator(
//                                   value: event == null
//                                       ? 0
//                                       : event.cumulativeBytesLoaded /
//                                           event.expectedTotalBytes!.toInt(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: 160,
//                     height: 160,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25.r),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: FileImage(
//                           File(cubit.selectedImagesList[index].path),

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
