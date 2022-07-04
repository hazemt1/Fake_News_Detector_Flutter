import 'package:fake_news/Api/DetectorAPI.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Detector extends StatefulWidget {
  PreferredSizeWidget? appBar;
  Detector({Key? key, this.appBar}) : super(key: key);

  @override
  State<Detector> createState() => _DetectorState();
}

class _DetectorState extends State<Detector> {
  String newsText = "";
  bool _detect = false;
  bool tf = true;
  double _result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: CustomDrawer(),
      appBar: widget.appBar ?? CustomAppBar(appBar: AppBar()),
      body: Row(
        children: [
          MediaQuery.of(context).size.width > 755
              ? Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).shadowColor,
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
                )
              : Container(),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 700),
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width > 755
                            ? MediaQuery.of(context).size.width * 0.45
                            : double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height:
                                    50,
                              ),
                              Center(
                                child: Text(
                                  AppLocalizations.of(context)!.detectNews,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(8),
                                constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.2,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.2,
                                  maxHeight:
                                      MediaQuery.of(context).size.width > 835
                                          ? MediaQuery.of(context).size.height *
                                              0.62
                                          : MediaQuery.of(context).size.height *
                                              0.62,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: TextField(
                                  onChanged: (t) {
                                    newsText = t;
                                  },
                                  maxLines: null,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                              Row(
                                children: [
                                  if (_detect)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: tf
                                                    ? Colors.greenAccent
                                                    : Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: tf
                                                      ? Colors.greenAccent
                                                      : Colors.redAccent,
                                                )),
                                            child: Text(tf
                                                ? AppLocalizations.of(context)!
                                                    .fact
                                                : AppLocalizations.of(context)!
                                                    .fake),
                                          ),
                                          const SizedBox(width: 10,),

                                          Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .confidence,
                                                maxLines: 5,
                                              ),
                                              Text(_result.toStringAsFixed(2)),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      double res = 0;
                                      if (BlocProvider.of<UserBloc>(context)
                                          .state
                                          .logInfo
                                          .isLoggedIn) {
                                        res = await DetectorAPI.userDetect(
                                            newsText,
                                            BlocProvider.of<UserBloc>(context)
                                                .state
                                                .logInfo
                                                .token!);
                                      } else {
                                        res = await DetectorAPI.guestDetect(
                                            newsText);
                                      }

                                      setState(() {
                                        _detect = true;
                                        if (res < 0.5) {
                                          tf = false;
                                          _result = (1 - res) * 100;
                                        } else {
                                          tf = true;
                                          _result = res * 100;
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          right: 16,
                                          left: 16),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        AppLocalizations.of(context)!.detect,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
