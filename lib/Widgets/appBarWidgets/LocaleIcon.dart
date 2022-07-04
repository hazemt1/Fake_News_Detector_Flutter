import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LocaleIcon extends StatelessWidget {
  const LocaleIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}