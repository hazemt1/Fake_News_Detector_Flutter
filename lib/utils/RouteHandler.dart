import 'package:fake_news/Screens/Detector.dart';
import 'package:fake_news/Screens/Home.dart';
import 'package:fake_news/Screens/ResetPassword/EnterNewPassword.dart';
import 'package:fake_news/Screens/ResetPassword/ForgetPassword.dart';
import 'package:fake_news/Screens/Review/ReviewScreen.dart';
import 'package:fake_news/Screens/Sign/SignIn.dart';
import 'package:fake_news/Screens/Sign/SignUp.dart';
import 'package:fake_news/Screens/Trending/Trending.dart';
import 'package:fake_news/utils/CustomPageRoute.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:flutter/material.dart';

import '../Screens/Sign/Sign.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = (settings.arguments ?? <String, dynamic>{}) as Map;
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => const Home(), settings: settings);
      case detectorRoute:
        return MaterialPageRoute(
            builder: (_) => Detector(appBar: arguments['appBar']),
            settings: settings);
      case detectorAnimatedRoute:
        return CustomPageRoute(
          child: Detector(appBar: arguments['appBar']),
          setting: const RouteSettings(name: detectorRoute),
        );
      case signInRoute:
        return MaterialPageRoute(
            builder: (_) => Sign(inUp: const SignIn()), settings: settings);
      case signUpRoute:
        return MaterialPageRoute(
            builder: (_) => Sign(inUp: const SignUp()), settings: settings);
      case trendingRoute:
        return MaterialPageRoute(
            builder: (_) => const TrendingScreen(), settings: settings);
      case reviewRoute:
        return MaterialPageRoute(
            builder: (_) => const ReviewScreen(), settings: settings);
      case forgetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => Sign(inUp: const ForgetPassword()),
            settings: settings);

      case enterNewPasswordRoute:
        {
          return MaterialPageRoute(
              builder: (_) => Sign(
                    inUp: const EnterNewPassword(),
                  ),
              settings: settings);
        }

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

extension NavigatorStateExtension on NavigatorState {
  void pushNamedIfNotCurrent(String routeName, {Object? arguments}) {
    if (!isCurrent(routeName)) {
      pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
