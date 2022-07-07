import 'package:fake_news/Api/AuthAPI.dart';
import 'package:fake_news/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool errorFlag = false;
  String error = '';
  String email = '';
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
                    // backgroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Center(
                      child: Text(
                        AppLocalizations.of(context)!.enterEmail,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    actions: [
                      if (errorFlag)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red)),
                            child: Text(error),
                          ),
                        ),
                      TextField(
                        onChanged: (t) {
                          email = t;
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.email,
                            hintStyle: Theme.of(context).textTheme.subtitle1),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ButtonTheme(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.resetPassword,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            onPressed: () async {
                              setState(() {
                                errorFlag = false;
                                error = '';
                              });
                              String res = await AuthAPI.forgetPassword(email);
                              if (res != '') {
                                setState(() {
                                  errorFlag = true;
                                  error = res;
                                });
                              } else {
                                Navigator.of(context)
                                    .pushNamed(enterNewPasswordRoute);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(AppLocalizations.of(context)!.otpMsg),
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
}
