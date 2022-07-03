import 'package:fake_news/Widgets/AppBarItem.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/utils/RouteHandler.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomDrawer extends StatelessWidget {
  late List<Widget> list;
  CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    list = [
      AppBarItem(
        text: AppLocalizations.of(context)!.home,
        function: () {
          Navigator.of(context).pushNamedIfNotCurrent(
            DetectorRoute,
            arguments: {
              'appBar': CustomAppBar(
                appBar: AppBar(),
              )
            },
          );
        },
      ),
      AppBarItem(
        text: AppLocalizations.of(context)!.trending,
        function: () {
          Navigator.of(context).pushNamedIfNotCurrent(TrendingRoute);
        },
      ),
      AppBarItem(
        text: AppLocalizations.of(context)!.searchedNews,
        function: () {},
      ),
      AppBarItem(
        text: AppLocalizations.of(context)!.history,
        function: () {},
      ),
      AppBarItem(
        text: AppLocalizations.of(context)!.review,
        function: () {},
      )
    ];
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
        ),
        child: Column(
          children: [
            const SizedBox(height: 200,),
            ListView.builder(
              shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: list[index],
              );
            })
          ],
        ),
      ),
    );
  }
}
