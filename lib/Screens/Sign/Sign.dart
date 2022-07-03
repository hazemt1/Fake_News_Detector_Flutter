import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
  Widget inUp;
  Sign({Key? key,required this.inUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(
        appBar: AppBar(),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/pattern.png"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.6,
              // height: 660,
              width: 500,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child:  Wrap(
                alignment: WrapAlignment.center,
                children: [
                  inUp,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
