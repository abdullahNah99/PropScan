import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/test_uploads_images/cubit/test_cubit.dart';
import 'package:untitled/modules/test_uploads_images/cubit/test_state.dart';
import 'package:untitled/modules/test_uploads_images/widgets/custom_test.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import 'package:untitled/shared/widgets/custome_progress_indicator.dart';

class TestMaps extends StatelessWidget {
  static const route = 'TestMaps';
  const TestMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestCubit()
        ..getNearestProps()
        ..getMyLocation(),
      child: const Scaffold(
        body: TestMapsBody(),
      ),
    );
  }
}

class TestMapsBody extends StatelessWidget {
  const TestMapsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestState>(
      listener: (context, state) {
        if (state is TestFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: 'XXXXXXXXX');
        }
      },
      builder: (context, state) {
        TestCubit cubit = BlocProvider.of<TestCubit>(context);
        if (state is TestSuccess) {
          return RefreshIndicator(
            onRefresh: () =>
                BlocProvider.of<TestCubit>(context).getNearestProps(),
            child: ListView.builder(
              itemCount: state
                  // .getNearetsProps(myX: cubit.myX!, myY: cubit.myY!)
                  .props
                  .length,
              itemBuilder: (context, index) => PropertyCard2(
                testCubit: cubit,
                index: index,
                testSuccess: state,
              ),
            ),
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}
