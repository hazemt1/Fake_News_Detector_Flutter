
import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
