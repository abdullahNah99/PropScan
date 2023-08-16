import 'package:flutter/cupertino.dart';
import 'package:untitled/modules/conversations_screen/conversations_screen.dart';
import 'package:untitled/modules/my_advertisements_screen/my_advertisements_screen.dart';
import 'package:untitled/modules/profile_screen/profile_screen.dart';
import 'package:untitled/modules/properties_screen/properties_screen.dart';
import 'package:untitled/modules/register_screen/register_screen.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import '../../modules/add_property_screen/add_property_screen.dart';
import '../../modules/login_screen/login_screen.dart';
import '../../modules/splash_screen/splash_screen.dart';

abstract class AppRouter {
  static final router = <String, WidgetBuilder>{
    LoginView.route: (context) => const LoginView(),
    AddPropertyView.route: (context) => const AddPropertyView(),
    PropertiesView.route: (context) => const PropertiesView(),
    RegisterView.route: (context) => const RegisterView(),
    SplashView.route: (context) => const SplashView(),
    ProfileView.route: (context) => ProfileView(user: FirebaseAPIs.me),
    ConversationsView.route: (context) => const ConversationsView(),
    MyAdvertisementsView.route: (context) => const MyAdvertisementsView(),
    // RegisterView.route: (context) => const RegisterView(),
    // GoogleMapView.route: (context) =>  GoogleMapView(),
  };
}
