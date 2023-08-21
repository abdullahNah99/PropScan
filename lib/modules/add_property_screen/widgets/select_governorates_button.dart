import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/functions/custom_dialog.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custome_dialog_button.dart';
import '../../../shared/widgets/custome_progress_indicator.dart';
import '../../../shared/widgets/custome_text_field.dart';
import '../cubit/add_property_cubit.dart';

class SelectGovernoratesButton extends StatelessWidget {
  final AddPropertyCubit addPropertyCubit;
  const SelectGovernoratesButton({super.key, required this.addPropertyCubit});

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
          hintText: addPropertyCubit.selctedGovernorate == null
              ? 'Governorate...'
              : addPropertyCubit.selctedGovernorate!.name,
          hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
          iconData: Icons.place,
          disableFocusNode: true,
          suffixIcon: addPropertyCubit.governoratesLoading
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
              : addPropertyCubit.selctedGovernorate == null
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
            FocusScope.of(context).unfocus();
            if (addPropertyCubit.selctedGovernorate != null) {
              addPropertyCubit.removeSelectedItem(helper: 'G');
            } else {
              await addPropertyCubit.getGovernorates();
              // ignore: use_build_context_synchronously
              CustomDialog.showCustomDialog(
                context,
                children: List.generate(
                  addPropertyCubit.governorates.length,
                  (index) {
                    return CustomDialogButton(
                      onTap: () {
                        addPropertyCubit.selectGovernorate(index: index);
                        Navigator.pop(context);
                        log(addPropertyCubit.selctedGovernorate?.name ?? '');
                      },
                      text: addPropertyCubit.governorates[index].name,
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
