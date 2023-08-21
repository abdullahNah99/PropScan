import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:untitled/shared/models/property_details_model.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.propertyDetails,
  });

  final PropertyDetailsModel propertyDetails;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
        items: List.generate(propertyDetails.images.length, (indexS) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Stack(
                        children: [
                          PhotoViewGallery.builder(
                            backgroundDecoration: BoxDecoration(
                                color: Colors.black.withOpacity(.85)),
                            pageController: PageController(initialPage: indexS),
                            builder: (BuildContext context, int index) {
                              return PhotoViewGalleryPageOptions(
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 4,
                                imageProvider: NetworkImage(
                                  "http://192.168.43.37:8000/${propertyDetails.images[index]['image']}",
                                ),
                                initialScale: PhotoViewComputedScale.contained,
                              );
                            },
                            itemCount: propertyDetails.images.length,
                            loadingBuilder: (context, event) => Center(
                              child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  value: event == null
                                      ? 0
                                      : event.cumulativeBytesLoaded /
                                          event.expectedTotalBytes!.toInt(),
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
                                    color: Colors.redAccent,
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(
                        "http://192.168.43.37:8000/${propertyDetails.images[indexS]['image']}",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
