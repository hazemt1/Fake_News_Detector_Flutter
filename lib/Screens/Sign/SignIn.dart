import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscure = true;
  bool checkBoxValue = false;
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
          children: [
            const Spacer(),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            const Spacer(flex: 2)
          ],
        ),
        Row(
          children: [
            const Spacer(flex: 4),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context)!.createNewAccount,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            const Spacer(flex: 11)
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        InkWell(
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
