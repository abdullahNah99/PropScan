import 'package:flutter/cupertino.dart';
import 'package:untitled/modules/properties_screen/properties_screen.dart';
import 'package:untitled/modules/register_screen/register_screen.dart';
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
    // RegisterView.route: (context) => const RegisterView(),
    // GoogleMapView.route: (context) =>  GoogleMapView(),
  };
}
