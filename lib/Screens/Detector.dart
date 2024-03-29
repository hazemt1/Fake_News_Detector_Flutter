import 'package:fake_news/Api/DetectorAPI.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:fake_news/Widgets/CustomDrawer.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/utils/preferences.dart';
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
  bool errorFlag = false;
  String error = "";
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
          if (MediaQuery.of(context).size.width > 755)
            const NewsSvg()
          else
            Container(),
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MediaQuery.of(context).size.height > 1000
                                  ? const SizedBox(
                                      height: 50,
                                    )
                                  : const SizedBox(
                                      height: 10,
                                    ),
                              Center(
                                child: Text(
                                  AppLocalizations.of(context)!.detectNews,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              if (errorFlag)
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    margin: const EdgeInsets.only(top: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.red)),
                                    child: Text(error),
                                  ),
                                ),
                              Wrap(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                      maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .width >
                                              835
                                          ? MediaQuery.of(context).size.height *
                                              0.62
                                          : MediaQuery.of(context).size.height *
                                              0.56,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: TextField(
                                      onChanged: (t) {
                                        newsText = t;
                                      },
                                      maxLines: null,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (_detect)
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
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
                                                ),
                                              ),
                                              child: Text(
                                                tf
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .fact
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .fake,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                        .confidence +
                                                    _result.toStringAsFixed(2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (!_detect) const Spacer(),
                                  InkWell(
                                    onTap: _submit,
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

  _submit() async {
    errorFlag = false;
    error = '';
    double res = 0;
    if(newsText==""){
      setState((){
        errorFlag=true;
        error= AppLocalizations.of(context)!.enterNews;
      });
      return;
    }
    if (BlocProvider.of<UserBloc>(context).state.logInfo.isLoggedIn) {
      res = await DetectorAPI.userDetect(
          newsText, BlocProvider.of<UserBloc>(context).state.logInfo.token!);
    } else {
      res = await DetectorAPI.guestDetect(newsText);
    }
    print(res);
    setState(() {
      if(res==-1){
        errorFlag = true;
        error = AppLocalizations.of(context)!.wrongLang;
      }else if(res==-99){
        Preferences.removeUser();
        BlocProvider.of<UserBloc>(context).add(const UserLogout());
      }else{
        _detect = true;

        if (res < 0.5) {
          tf = false;
          _result = (1 - res) * 100;
        } else {
          tf = true;
          _result = res * 100;
        }
      }
    });
  }
}

class NewsSvg extends StatelessWidget {
  const NewsSvg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
