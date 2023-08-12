// import 'dart:async';

// import 'package:flutter/material.dart';

// import '../LoginPage/login.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// @override
// class _SplashScreenState extends State<SplashScreen> {
//   void initState() {
//     super.initState();
//     Timer(
//       Duration(seconds: 3),
//       () {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) {
//           return login();
//         }));
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Stack(
//         children: [
//           Center(
//             child: Image(
//                 image: AssetImage('assets/images/icon.png'),
//                 height: 100,
//                 width: 100),
//           ),
//         ],
//       )),
//     );
//   }
// }

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/modules/properties_screen/properties_screen.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
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

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
              // systemNavigationBarColor: Colors.white,
              // statusBarColor: Colors.white,
              ),
        );
        if (FirebaseAPIs.auth.currentUser != null &&
            CacheHelper.getData(key: 'Token') != null) {
          log('\n User : ${FirebaseAuth.instance.currentUser}');
          (await GetMyInformationService.getMyInfo(
                  token: CacheHelper.getData(key: 'Token')))
              .fold(
            (failure) {
              CustomeSnackBar.showErrorSnackBar(context,
                  msg: failure.errorMessege);
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

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome To PropScan'),
      ),
      body: const Column(
        children: [
          Center(
            child: Text('Test'),
          )
        ],
      ),
    );
  }
}
