import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnimatedCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const AnimatedCustomAppBar({Key? key, required this.appBar}) : super(key: key);

  @override
  State<AnimatedCustomAppBar> createState() => _AnimatedCustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _AnimatedCustomAppBarState extends State<AnimatedCustomAppBar> with SingleTickerProviderStateMixin{
  /// you can add more fields that meet your needs
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: BlocProvider.of<SettingBloc>(context)
        .state
        .settings
        .currentLocale ==
        'en'
        ? const Offset(-0.5, 0)
        : const Offset(0.5, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return SlideTransition(
      position: _offsetAnimation,
      child: CustomAppBar(appBar:widget.appBar),
    );
  }
}

