import 'package:fake_news/Api/AuthAPI.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/utils/RouteHandler.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/User.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscure = true;
  bool checkBoxValue = false;
  String email = '';
  String password = '';
  bool errorFlag = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          AppLocalizations.of(context)!.login,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(
          height: 30,
        ),
        if (errorFlag)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red)),
            child: Text(error),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: TextField(
              onChanged: (s) {
                email = s;
              },
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email,
                  hintStyle: Theme.of(context).textTheme.subtitle1,
                  border: InputBorder.none),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (s) {
                      password = s;
                    },
                    obscureText: obscure,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.password,
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                        border: InputBorder.none),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        obscure = !obscure;
                      },
                    );
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Spacer(flex: 2),
            Checkbox(
                value: checkBoxValue,
                onChanged: (c) {
                  setState(() {
                    checkBoxValue = !checkBoxValue;
                  });
                }),
            Text(AppLocalizations.of(context)!.stayLoggedIn),
            const Spacer(flex: 5),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 100, right: 107),
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 100, right: 107),
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    AppLocalizations.of(context)!.createNewAccount,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamedIfNotCurrent(SignUpRoute);
                },
              ),
            ),
            const Spacer(flex: 11)
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        InkWell(
          onTap: _signIn,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
            child: Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
  _signIn() async {
    setState((){
      errorFlag=false;
      error='';
    });
    List res = await AuthAPI.login(User(email: email, password: password));
    if (res.length == 1) {
      setState(() {
        errorFlag = true;
        error = res[0];
      });
    } else {
      if (checkBoxValue) {
        Preferences.setToken(res[0]);
      }
      BlocProvider.of<UserBloc>(context).add(
        UserLogin(
          user: User(
            name: res[1],
            email: res[2],
            id: res[3],
          ),
          token: res[0],
        ),
      );
      Navigator.of(context).popAndPushNamed(HomeRoute);
    }
  }
}
