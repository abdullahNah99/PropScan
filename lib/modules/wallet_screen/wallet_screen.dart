import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/main.dart';
import 'package:untitled/modules/wallet_screen/cubit/wallet_cubit.dart';
import 'package:untitled/modules/wallet_screen/cubit/wallet_states.dart';
import 'package:untitled/modules/wallet_screen/widgets/wallet_data_item.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/widgets/custome_progress_indicator.dart';

class WalletView extends StatelessWidget {
  static const route = 'WalletView';
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit()..getWalletOperations(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wallet Details'),
        ),
        body: const WalletViewBody(),
      ),
    );
  }
}

class WalletViewBody extends StatelessWidget {
  const WalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletStates>(
      listener: (context, state) {
        if (state is WalletFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is WalletSuccess) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                // height: 100000,
                width: screenSize.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      state.walletData.length,
                      (index) => WalletDataItem(
                        value: state.walletData[index].value,
                        date: state.walletData[index].date,
                        type: state.walletData[index].type,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.defaultColor,
                  ),
                  child: Text(
                    'Balance: ${state.getBalance()}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}
