import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  RouteSettings? setting;
  CustomPageRoute({
    required this.child,
    this.setting,
  }) : super(
            transitionDuration: const Duration(milliseconds: 400),
            settings: setting,
            pageBuilder: (
              context,
              animation,
              secondaryAnimation,
            ) =>
                child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
                begin: BlocProvider.of<SettingBloc>(context)
                            .state
                            .settings
                            .currentLocale ==
                        'en'
                    ? const Offset(0.5, 0)
                    : const Offset(-0.5, 0),
                end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
