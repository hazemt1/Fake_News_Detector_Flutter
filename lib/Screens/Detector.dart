import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Detector extends StatelessWidget {
  PreferredSizeWidget? appBar;
  Detector({Key? key,this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: CustomDrawer(),
      appBar: appBar??CustomAppBar(appBar: AppBar()),
      body: Row(
        children: [
          MediaQuery.of(context).size.width>700?
          Expanded(
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
          ):Container(),
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
                        width: MediaQuery.of(context).size.width>700?
                        MediaQuery.of(context).size.width * 0.45: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.06,),
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

                                  minWidth: MediaQuery.of(context).size.width * 0.2,
                                  maxHeight:MediaQuery.of(context).size.width >835?
                                      MediaQuery.of(context).size.height * 0.62:MediaQuery.of(context).size.height *0.62,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
                                ),
                                child: TextField(
                                  maxLines: null,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8, right: 16, left: 16),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).colorScheme.primary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        AppLocalizations.of(context)!.detect,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
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
