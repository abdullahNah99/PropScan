import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/modules/add_property_screen/widgets/custom_page_view.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_governorates_button.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_regions_button.dart';
import 'package:untitled/modules/add_property_screen/widgets/select_type_buttons.dart';
import 'package:untitled/modules/add_property_screen/widgets/selected_images_list.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/widgets/custome_button.dart';
import '../../shared/constant/const.dart';
import '../../shared/functions/custom_snack_bar.dart';
import '../../shared/widgets/custome_progress_indicator.dart';
import 'cubit/add_property_cubit.dart';
import 'cubit/add_property_states.dart';

class AddPropertyView extends StatelessWidget {
  static const route = 'AddPropertyView';
  const AddPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPropertyCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Property'),
              backgroundColor: AppColors.defaultColor,
              actions: const [
                Icon(Icons.add_business_outlined),
                SizedBox(width: 5),
              ],
            ),
            body: const AddPropertyViewBody(),
          ),
        ),
      ),
    );
  }
}

class AddPropertyViewBody extends StatelessWidget {
  const AddPropertyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    AddPropertyCubit addPropertyCubit =
        BlocProvider.of<AddPropertyCubit>(context);
    return BlocConsumer<AddPropertyCubit, AddPropertyStates>(
      listener: (context, state) {
        if (state is AddPropertyFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        } else if (state is AddPropertySuccess) {
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Property Added Successfully',
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        if (state is AddPropertyLoading) {
          return const CustomeProgressIndicator();
        } else {
          return _AddPropertyBody(addPropertyCubit: addPropertyCubit);
        }
      },
    );
  }
}

class _AddPropertyBody extends StatelessWidget {
  final AddPropertyCubit addPropertyCubit;
  const _AddPropertyBody({required this.addPropertyCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyStates>(
      builder: (context, state) {
        AddPropertyCubit cubit = BlocProvider.of<AddPropertyCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              SelectedImagesList(cubit: cubit),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  cubit.selectimages();
                },
                child: Text(
                  'Choose Images ',
                  style: TextStyle(color: HexColor(bp)),
                ),
              ),
              SizedBox(
                height: 75,
                child: SelectTypeButtons(cubit: cubit),
              ),
              SizedBox(height: 20.h),
              CustomPageView(addPropertyCubit: cubit),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectGovernoratesButton(addPropertyCubit: addPropertyCubit),
                  SelectRegionsButton(addPropertyCubit: addPropertyCubit),
                ],
              ),
              SizedBox(height: 30.h),
              CustomeButton(
                color: AppColors.defaultColor,
                text: 'Continue',
                onPressed: () async {
                  if (cubit.formKey.currentState!.validate()) {
                    if (cubit.selectedRegion == null) {
                      CustomeSnackBar.showSnackBar(
                        context,
                        msg: 'Please Select Region',
                        color: Colors.red,
                      );
                    } else if (cubit.selectedImagesList.isEmpty) {
                      CustomeSnackBar.showSnackBar(
                        context,
                        msg: 'Please Select Images',
                        color: Colors.red,
                      );
                    } else if (cubit.selectedTypeIndex == 0 &&
                        !(cubit.chackDirections())) {
                      CustomeSnackBar.showSnackBar(
                        context,
                        msg: 'Please Select Direction',
                        color: Colors.red,
                      );
                    } else {
                      await cubit.storeProperty();
                    }
                  }
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }
}
