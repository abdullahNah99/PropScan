import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/modules/properties_screen/properties_screen.dart';
import 'package:untitled/modules/splash_screen/widgets/sliding_text.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/auth/get_my_information_service.dart';
import '../../shared/network/remote/firebase/firebase_apis.dart';
import '../login_screen/login_screen.dart';

class SplashView extends StatefulWidget {
  static const route = 'SplashView';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    FirebaseAPIs.getSelfInfo();
    _initSlidingAnimation();
    _navigateToHomeView();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SlidingText(slidingAnimation: slidingAnimation),
          ],
        ),
      ),
    );
  }

  void _initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void _navigateToHomeView() {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        // SystemChrome.setSystemUIOverlayStyle(
        //   const SystemUiOverlayStyle(
        //       systemNavigationBarColor: Colors.black,
        //       statusBarColor: Colors.black,
        //       ),
        // );
        if (FirebaseAPIs.auth.currentUser != null &&
            CacheHelper.getData(key: 'Token') != null) {
          log('\n User : ${FirebaseAuth.instance.currentUser}');
          (await GetMyInformationService.getMyInfo(
                  token: CacheHelper.getData(key: 'Token')))
              .fold(
            (failure) {
              // CustomeSnackBar.showErrorSnackBar(context,
              //     msg: failure.errorMessege);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginView();
                  },
                ),
              );
            },
            (userModel) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PropertiesView(userModel: userModel);
                  },
                ),
              );
            },
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginView();
              },
            ),
          );
        }
      },
    );
  }
}
