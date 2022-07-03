import 'package:fake_news/Widgets/AppBarItem.dart';
import 'package:fake_news/Widgets/SignButton.dart';
import 'package:fake_news/bloc/setting/setting_bloc.dart';
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
      AppBarItem(
        text: AppLocalizations.of(context)!.history,
        function: () {},
      ),
      AppBarItem(
        text: AppLocalizations.of(context)!.review,
        function: () {},
      )
    ];

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: MediaQuery.of(context).size.width > 550 ? false : true,
      leading: MediaQuery.of(context).size.width > 1200
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
          if (MediaQuery.of(context).size.width > 1200) const Spacer(),
          if (MediaQuery.of(context).size.width > 1200)
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
          if (MediaQuery.of(context).size.width > 550) const Spacer()
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          child: Tooltip(
            message: AppLocalizations.of(context)!.changeL,
            child: InkWell(
              onTap: () {
                if (BlocProvider.of<SettingBloc>(context)
                        .state
                        .settings
                        .currentLocale ==
                    "en") {
                  Preferences.setLanguage("ar");
                } else {
                  Preferences.setLanguage("en");
                }
                BlocProvider.of<SettingBloc>(context).add(
                  ChangeLang(
                    settings:
                        BlocProvider.of<SettingBloc>(context).state.settings,
                  ),
                );
              },
              child: Icon(
                CupertinoIcons.globe,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          child: Tooltip(
            message: BlocProvider.of<SettingBloc>(context)
                        .state
                        .settings
                        .themeMode ==
                    ThemeMode.light
                ? AppLocalizations.of(context)!.darkTheme
                : AppLocalizations.of(context)!.lightTheme,
            child: InkWell(
              onTap: () {
                if (BlocProvider.of<SettingBloc>(context)
                        .state
                        .settings
                        .themeMode ==
                    ThemeMode.light) {
                  Preferences.saveThemePreference(ThemeMode.dark);
                } else {
                  Preferences.saveThemePreference(ThemeMode.light);
                }
                BlocProvider.of<SettingBloc>(context).add(
                  ToggleTheme(
                    settings:
                        BlocProvider.of<SettingBloc>(context).state.settings,
                  ),
                );
              },
              child: BlocProvider.of<SettingBloc>(context)
                          .state
                          .settings
                          .themeMode ==
                      ThemeMode.light
                  ? Icon(
                      CupertinoIcons.moon_fill,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : Icon(
                      CupertinoIcons.sun_min,
                      color: Theme.of(context).iconTheme.color,
                    ),
            ),
          ),
        ),
        if (MediaQuery.of(context).size.width > 600)
          SignButton(
            text: AppLocalizations.of(context)!.login,
            function: () {
              Navigator.of(context).pushNamedIfNotCurrent(SignInRoute);
            },
          ),
        if (MediaQuery.of(context).size.width > 600)
          SignButton(
            text: AppLocalizations.of(context)!.signUp,
            function: () {
              Navigator.of(context).pushNamedIfNotCurrent(SignUpRoute);
            },
          ),
        // Container(
        //   margin: const EdgeInsets.only(right: 16, left: 8),
        //   child: DropdownButtonHideUnderline(
        //     child: DropdownButton2(
        //       customButton: Icon(
        //         CupertinoIcons.profile_circled,
        //         color: Theme.of(context).iconTheme.color,
        //       ),
        //       dropdownWidth: 100,
        //       dropdownDecoration: BoxDecoration(
        //           borderRadius: const BorderRadius.all(Radius.circular(8)),
        //           color: Theme.of(context).primaryColor),
        //       style: Theme.of(context).textTheme.bodyText1,
        //       items: [
        //         DropdownMenuItem(
        //           value: "sign in",
        //           child: Text(AppLocalizations.of(context)!.login),
        //         ),
        //         DropdownMenuItem(
        //           value: "sign up",
        //           child: Text(AppLocalizations.of(context)!.signUp),
        //         ),
        //       ],
        //       onChanged: (d) {
        //         if (d == "sign in") {
        //           Navigator.of(context).pushNamedIfNotCurrent(SignInRoute);
        //         } else if (d == "sign up") {
        //           Navigator.of(context).pushNamedIfNotCurrent(SignUpRoute);
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
