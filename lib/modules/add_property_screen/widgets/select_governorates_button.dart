import 'dart:developer';
import 'package:flutter/material.dart';
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
    return CustomeTextField(
      hintText: addPropertyCubit.selctedGovernorate == null
          ? 'Select Governorate ...'
          : addPropertyCubit.selctedGovernorate!.name,
      hintStyle: addPropertyCubit.selctedGovernorate == null
          ? null
          : const TextStyle(color: Colors.black),
      iconData: Icons.place,
      disableFocusNode: true,
      suffixIcon: addPropertyCubit.governoratesLoading
          ? SizedBox(
              width: 5,
              child: Transform.scale(
                scale: .5,
                child: const CustomeProgressIndicator(strokeWidth: 2),
              ),
            )
          : const Icon(
              Icons.expand_more_sharp,
              size: 40,
              color: AppColors.defaultColor,
            ),
      onTap: () async {
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
      },
    );
  }
}
