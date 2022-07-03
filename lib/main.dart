import 'package:fake_news/bloc/setting/setting_bloc.dart';
import 'package:fake_news/utils/RouteHandler.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:fake_news/utils/themedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc(),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          BlocProvider.of<SettingBloc>(context).add(
            SetSetting(
              settings: Settings(
                themeMode: Preferences.getThemePreference(),
                currentLocale: Preferences.getLanguage(),
              ),
            ),
          );
          return MaterialApp(
            themeMode:
                BlocProvider.of<SettingBloc>(context).state.settings.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'Flutter Demo',
            theme: MyThemeData.lightTheme,
            darkTheme: MyThemeData.darkTheme,
            locale: Locale.fromSubtags(
              languageCode: BlocProvider.of<SettingBloc>(context)
                  .state
                  .settings
                  .currentLocale,
            ),
            onGenerateRoute: RouteHandler.generateRoute,
            initialRoute: HomeRoute,
          );
        },
      ),
    );
  }
}
