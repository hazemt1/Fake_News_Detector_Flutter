import 'package:fake_news/Screens/ResetPassword/OtpCode.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/pattern.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: Center(
                  child: Text(
                    AppLocalizations.of(context)!.enterEmail,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                actions: [
                  TextField(
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
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.resetPassword,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpForm()),
                          );
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
            ),
          ),
        ],
      ),
    );
  }
}
