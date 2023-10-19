import 'package:flutter/material.dart';
import 'string_manager.dart';
import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/main_page.dart';
import '../pages/forget_password_page.dart';
import '../pages/settings_page.dart';
import '../pages/mode_page.dart';
import '../pages/about_page.dart';
import '../pages/mobile_number_page.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String settingRoute = "/settings";
  static const String modeRoute = "/mode";
  static const String aboutRoute = "/about";
  static const String mobileNumber = "/mobileNumber";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPageView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPageView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPageView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPageView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainPageView());
      case Routes.settingRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPageView());
      case Routes.modeRoute:
        return MaterialPageRoute(builder: (_) => const ModePageView());
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutPageView());
      case Routes.mobileNumber:
        return MaterialPageRoute(builder: (_) => const MobileNumberPageView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(builder: (_) =>
        Scaffold(
          appBar: AppBar(title: const Text(AppString.error),),
          body: const Center(
            child: Text(AppString.noRouteFound),
          ),
        )
    );
  }
}

