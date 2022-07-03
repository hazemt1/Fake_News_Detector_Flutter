
import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  final String text;
  final Function function;
  const AppBarItem({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        margin: const EdgeInsets.only(right: 18, left: 18),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
