import 'package:equatable/equatable.dart';

import '../../../shared/network/remote/services/wallet/index_service.dart';

abstract class WalletStates extends Equatable {
  const WalletStates();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletStates {}

final class WalletLoading extends WalletStates {}

final class WalletFailure extends WalletStates {
  final String failureMsg;

  const WalletFailure({required this.failureMsg});
}

final class WalletSuccess extends WalletStates {
  final List<WalletDataModel> walletData;

  const WalletSuccess({required this.walletData});

  int getBalance() {
    int sum = 0;
    for (WalletDataModel item in walletData) {
      if (item.type) {
        sum += item.value;
      } else {
        sum -= item.value;
      }
    }
    return sum;
  }
}
