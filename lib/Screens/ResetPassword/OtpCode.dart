import 'package:fake_news/Screens/ResetPassword/EnterPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
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
                    AppLocalizations.of(context)!.enterOtp,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mySizedBox(context),
                      mySizedBox(context),
                      mySizedBox(context),
                      mySizedBox(context),
                      mySizedBox(context)
                    ],
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
                          AppLocalizations.of(context)!.enter,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EnterPassword()),
                          );
                        },
                      ),
                    ),
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

Widget mySizedBox(BuildContext context) {
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
          }
        },
        decoration: InputDecoration(
          border: new OutlineInputBorder(),
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
