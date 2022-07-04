import 'package:fake_news/Widgets/AppBarItem.dart';
import 'package:fake_news/Widgets/appBarWidgets/LocaleIcon.dart';
import 'package:fake_news/Widgets/appBarWidgets/SignButton.dart';
import 'package:fake_news/Widgets/appBarWidgets/ThemeIcon.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/utils/RouteHandler.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const CustomAppBar({Key? key, required this.appBar}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool selected = false;

  late List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    tabs = [
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
      if (BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
        AppBarItem(
          text: AppLocalizations.of(context)!.history,
          function: () {},
        ),
      if (BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
        AppBarItem(
          text: AppLocalizations.of(context)!.review,
          function: () {
            Navigator.of(context).pushNamedIfNotCurrent(ReviewRoute);
          },
        )
    ];

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AppBar(
          automaticallyImplyLeading: false,
          centerTitle: MediaQuery.of(context).size.width > 600 ? false : true,
          leading: (MediaQuery.of(context).size.width > 1117 &&
              BlocProvider.of<UserBloc>(context)
                  .state
                  .logInfo
                  .isLoggedIn) ||
              (MediaQuery.of(context).size.width > 998 &&
                  !BlocProvider.of<UserBloc>(context)
                      .state
                      .logInfo
                      .isLoggedIn)
              ? null
              : Builder(
                  builder: (context) => // Ensure Scaffold is in context
                      IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer()),
                ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedIfNotCurrent(HomeRoute);
                },
                child: Text(
                  AppLocalizations.of(context)!.logo,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              if (MediaQuery.of(context).size.width > 600) const Spacer(),
              if ((MediaQuery.of(context).size.width > 1117 &&
                      BlocProvider.of<UserBloc>(context)
                          .state
                          .logInfo
                          .isLoggedIn) ||
                  (MediaQuery.of(context).size.width > 998 &&
                      !BlocProvider.of<UserBloc>(context)
                      .state
                      .logInfo
                      .isLoggedIn))
                Container(
                  constraints: const BoxConstraints(maxHeight: 50),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 75),
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      return tabs[index];
                    },
                  ),
                ),
              if (MediaQuery.of(context).size.width > 600) const Spacer()
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          actions: [
            const LocaleIcon(),
            const ThemeIcon(),
            if (MediaQuery.of(context).size.width > 600 &&
                !BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
              Row(
                children: [
                  SignButton(
                    text: AppLocalizations.of(context)!.login,
                    function: () {
                      Navigator.of(context).pushNamedIfNotCurrent(SignInRoute);
                    },
                  ),
                  SignButton(
                    text: AppLocalizations.of(context)!.signUp,
                    function: () {
                      Navigator.of(context).pushNamedIfNotCurrent(SignUpRoute);
                    },
                  ),
                ],
              ),
            if (MediaQuery.of(context).size.width > 600 &&
                BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn)
              SignButton(
                text: AppLocalizations.of(context)!.signOut,
                function: () {
                  setState(() {
                    Preferences.removeUser();
                    BlocProvider.of<UserBloc>(context).add(const UserLogout());
                  });
                  if(Navigator.of(context).isCurrent(ReviewRoute)){
                    Navigator.of(context).popAndPushNamed(HomeRoute);
                  }



                },
              ),
          ],
        );
      },
    );
  }
}
