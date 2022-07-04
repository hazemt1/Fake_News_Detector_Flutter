import 'package:fake_news/Screens/Detector.dart';
import 'package:fake_news/Screens/Home.dart';
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
      case HomeRoute:
        return MaterialPageRoute(
            builder: (_) => const Home(), settings: settings);
      case DetectorRoute:
        return MaterialPageRoute(
            builder: (_) => Detector(appBar: arguments['appBar']),
            settings: settings);
      case DetectorAnimatedRoute:
        return CustomPageRoute(
          child: Detector(appBar: arguments['appBar']),
          setting: const RouteSettings(name: DetectorRoute),
        );
      case SignInRoute:
        return MaterialPageRoute(builder: (_)=> Sign(inUp: const SignIn()),settings: settings);
      case SignUpRoute:
        return MaterialPageRoute(builder: (_)=> Sign(inUp: const SignUp()),settings: settings);
      case TrendingRoute:
        return MaterialPageRoute(builder: (_)=> const TrendingScreen(),settings: settings);
      case ReviewRoute:
        return MaterialPageRoute(builder: (_)=> const ReviewScreen(),settings: settings);

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
