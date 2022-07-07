import 'package:fake_news/Api/AuthAPI.dart';
import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/models/User.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({Key? key}) : super(key: key);

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  final _resetPasswordFormKey = GlobalKey<FormState>();
  String password = '';
  String confirmPassword = '';
  FocusNode passwordFocus = FocusNode();
  bool obscure = true;
  bool errorFlag = false;
  String error = '';
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.6,
          // height: 660,
          width: 500,
          decoration: BoxDecoration(
            color: Theme.of(context).shadowColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                children: [
                  AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Center(
                      child: Text(
                        AppLocalizations.of(context)!.enterPassword,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    actions: [
                      if (errorFlag)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red)),
                            child: Text(error),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mySizedBox(context, 1),
                          mySizedBox(context, 2),
                          mySizedBox(context, 3),
                          mySizedBox(context, 4),
                          mySizedBox(context, 5),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Form(
                          key: _resetPasswordFormKey,
                          child: Column(
                            children: [
                              //Password Widget
                              passwordWidget(
                                context: context,
                                validator: passwordValidation,
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                field: "password",
                              ),
                              //Confirm Password Widget
                              passwordWidget(
                                context: context,
                                validator: confirmPasswordValidation,
                                hintText: AppLocalizations.of(context)!
                                    .confirmPassword,
                                field: "confirm password",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
                          onTap: validate,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 12),
                            child: Text(
                              AppLocalizations.of(context)!.enter,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding customPadding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: child,
      ),
    );
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    } else if (value.length < 8) {
      return AppLocalizations.of(context)!.password8char;
    }
    return null;
  }

  Widget mySizedBox(BuildContext context, int position) {
    return SizedBox(
      height: 40,
      width: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: TextFormField(
          style: Theme.of(context).textTheme.subtitle1,
          cursorColor: Theme.of(context).backgroundColor,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
              if (code.length >= 5) {
                code = code.substring(0, position - 1) +
                    value +
                    code.substring(position);
              } else {
                code += value;
              }
            }
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    } else if (value != password) {
      return AppLocalizations.of(context)!.passwordDoesNotMatch;
    }
    return null;
  }

  Padding passwordWidget(
      {required BuildContext context,
      required Function validator,
      required hintText,
      required String field}) {
    return customPadding(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                if (field == "password") {
                  password = value;
                }
              },
              obscureText: obscure,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.subtitle1,
                border: InputBorder.none,
              ),
              validator: (text) => validator(text),
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
    );
  }

  void validate() async {
    setState(() {
      errorFlag = false;
      error = '';
    });
    if (_resetPasswordFormKey.currentState?.validate() == true) {
      List res = await AuthAPI.resetPassword(code, password);
      if (res.length == 1) {
        setState(() {
          errorFlag = true;
          error = res[0];
        });
      } else {
        Preferences.setToken(res[0]);
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
        Navigator.of(context).popAndPushNamed(homeRoute);
      }
    }
  }
}
