import 'package:fake_news/Widgets/AppBarItem.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/appBarWidgets/SignButton.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/utils/RouteHandler.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomDrawer extends StatefulWidget {

  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late List<Widget> list;

  @override
  Widget build(BuildContext context) {
    list = [
      AppBarItem(
        text: AppLocalizations.of(context)!.home,
        function: () {
          Navigator.of(context).pushNamedIfNotCurrent(
            detectorRoute,
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
          Navigator.of(context).pushNamedIfNotCurrent(trendingRoute);
        },
      ),
      AppBarItem(
        text: AppLocalizations.of(context)!.searchedNews,
        function: () {
          Navigator.of(context).pushNamedIfNotCurrent(searchedNewsRoute);
        },
      ),
      if(BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
        AppBarItem(
          text: AppLocalizations.of(context)!.history,
          function: () {
            Navigator.of(context).pushNamedIfNotCurrent(historyRoute);
          },
        ),
      if(BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
        AppBarItem(
          text: AppLocalizations.of(context)!.review,
          function: () {
            Navigator.of(context).pushNamedIfNotCurrent(reviewRoute);
          },
        )
    ];
    print(MediaQuery.of(context).size.height);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(MediaQuery.of(context).size.height>500)
              const SizedBox(height: 200,),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: list[index],
                );
              },),
              if (
                  !BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignButton(
                      text: AppLocalizations.of(context)!.login,
                      function: () {
                        Navigator.of(context).pushNamedIfNotCurrent(signInRoute);
                      },
                    ),
                    SignButton(
                      text: AppLocalizations.of(context)!.signUp,
                      function: () {
                        Navigator.of(context).pushNamedIfNotCurrent(signUpRoute);
                      },
                    ),
                  ],
                ),
              if (BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
                SignButton(
                  text: AppLocalizations.of(context)!.signOut,
                  function: () {
                    setState(() {
                      Preferences.removeUser();
                      BlocProvider.of<UserBloc>(context).add(const UserLogout());
                    });
                    if(Navigator.of(context).isCurrent(reviewRoute)){
                      Navigator.of(context).popAndPushNamed(homeRoute);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
