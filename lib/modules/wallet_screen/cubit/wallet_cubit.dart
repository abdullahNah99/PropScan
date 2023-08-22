import 'package:bloc/bloc.dart';
import 'package:untitled/modules/wallet_screen/cubit/wallet_states.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/wallet/index_service.dart';

class WalletCubit extends Cubit<WalletStates> {
  WalletCubit() : super(WalletInitial());

  Future<void> getWalletOperations() async {
    emit(WalletLoading());
    (await WalletIndexService.walletIndex(
            token: await CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) {
        emit(WalletFailure(failureMsg: failure.errorMessege));
      },
      (walletData) {
        emit(WalletSuccess(walletData: walletData));
      },
    );
  }
}
