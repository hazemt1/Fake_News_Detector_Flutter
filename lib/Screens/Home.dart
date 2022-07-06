import 'package:fake_news/Widgets/AnimatedAppBar.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(
        appBar: AppBar(),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/pattern.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      MediaQuery.of(context).size.height>1000?
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ):
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.homeScreenHeader,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Text(
                        AppLocalizations.of(context)!.homeScreenBody,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            detectorAnimatedRoute,
                            arguments: {
                              'appBar': AnimatedCustomAppBar(
                                appBar: AppBar(),
                              )
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          margin: const EdgeInsets.only(top: 30),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, right: 8),
                                child: Text(
                                  AppLocalizations.of(context)!.detect,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (MediaQuery.of(context).size.width > 700)
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).shadowColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: SvgPicture.asset(
                              "assets/no_news.svg",
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            detectorAnimatedRoute,
                            arguments: {
                              'appBar': AnimatedCustomAppBar(
                                appBar: AppBar(),
                              )
                            },
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ))
                  ],
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
