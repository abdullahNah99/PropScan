import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_states.dart';
import 'package:untitled/shared/models/firebase_models/chat_user.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import 'package:untitled/shared/network/remote/services/auth/logout_service.dart';
import '../../../shared/functions/custom_snack_bar.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../login_screen/login_screen.dart';

class PropertiesCubit extends Cubit<PropertiesStates> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ChatUser? chatUser;
  PropertiesCubit() : super(PropertiesInitial());

  Future<void> logOut(BuildContext context) async {
    emit(PropertiesLoading());
    await FirebaseAPIs.auth.signOut().then(
      (value) async {
        (await LogOutService.logout(
          token: await CacheHelper.getData(key: 'Token'),
        ))
            .fold(
          (failure) {
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Something Went Wrong, Please Try Again',
              color: Colors.red,
            );
          },
          (success) async {
            await CacheHelper.deletData(key: 'Token');
            // ignore: use_build_context_synchronously
            Navigator.popAndPushNamed(context, LoginView.route);
          },
        );
      },
    );
  }

  // Future<void> getPropertyChatUser({required int localUserID}) async {
  //   emit(PropertiesLoading());
  //   (await FirebaseAPIs.getPropertyChatUser(localUserID: localUserID)).fold(
  //     (failure) {
  //       emit(PropertiesFailure(errorMessage: failure.errorMessege));
  //       // getPropertyChatUser(localUserID: localUserID);
  //     },
  //     (chatUser) {
  //       emit(GetPropertyChatUserSuccess(chatUser: chatUser));
  //     },
  //   );
  // }

  Future<void> getPropertyChatUser({required int localUserID}) async {
    emit(PropertiesLoading());
    try {
      FirebaseAPIs.firesotre
          .collection('users')
          .where('local_user_id', isEqualTo: localUserID)
          .snapshots()
          .listen((event) {
        emit(GetPropertyChatUserSuccess(
            chatUser: ChatUser.factory(event.docs[0].data())));
      });
    } catch (ex) {
      emit(PropertiesFailure(errorMessage: ex.toString()));
    }
  }
}
