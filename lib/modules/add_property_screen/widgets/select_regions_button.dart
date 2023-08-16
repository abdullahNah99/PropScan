import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/google_map_screen/google_map_screen.dart';
import '../../../shared/functions/custom_dialog.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custome_dialog_button.dart';
import '../../../shared/widgets/custome_progress_indicator.dart';
import '../../../shared/widgets/custome_text_field.dart';
import '../cubit/add_property_cubit.dart';

class SelectRegionsButton extends StatelessWidget {
  final AddPropertyCubit addPropertyCubit;
  const SelectRegionsButton({super.key, required this.addPropertyCubit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: AppColors.color2,
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        CustomeTextField(
          width: 160.w,
          noOutlineBorder: true,
          outLineBorderColor: Colors.transparent,
          hintText: addPropertyCubit.selectedRegion == null
              ? 'Region...'
              : addPropertyCubit.selectedRegion!.name,
          hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
          iconData: Icons.add_location_rounded,
          disableFocusNode: true,
          suffixIcon: addPropertyCubit.regionsLoading
              ? SizedBox(
                  width: 5,
                  child: Transform.scale(
                    scale: .5,
                    child: const CustomeProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              : addPropertyCubit.selectedRegion == null
                  ? const Icon(
                      Icons.expand_more_sharp,
                      size: 40,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.playlist_remove_sharp,
                      size: 30,
                      color: Colors.white,
                    ),
          onTap: () async {
            if (addPropertyCubit.selectedRegion != null) {
              addPropertyCubit.removeSelectedItem(helper: 'R');
            } else {
              await addPropertyCubit.getGovernorateRegions(context);
              if (addPropertyCubit.selctedGovernorate != null) {
                // ignore: use_build_context_synchronously
                CustomDialog.showCustomDialog(
                  context,
                  children: List.generate(
                    addPropertyCubit.regions.length,
                    (index) {
                      return CustomDialogButton(
                        onTap: () {
                          addPropertyCubit.selectRegion(index: index);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GoogleMapView(
                                select: true,
                                locations: const [],
                                lat: addPropertyCubit.regions[index].x,
                                lon: addPropertyCubit.regions[index].y,
                                addPropertyCubit: addPropertyCubit,
                              ),
                            ),
                          );
                          log(addPropertyCubit.selectedRegion?.name ?? '');
                        },
                        text: addPropertyCubit.regions[index].name,
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
