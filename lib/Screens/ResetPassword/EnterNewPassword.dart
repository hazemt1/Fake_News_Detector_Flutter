import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CustomDrawer.dart';

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({Key? key}) : super(key: key);

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  final _registerFormKey = GlobalKey<FormState>();
  String password = '';
  FocusNode passwordFocus = FocusNode();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Theme
          .of(context)
          .primaryColor,
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
                    Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    BlendMode.srcIn,
                  ),
                ),
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              child: AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: Center(
                  child: Text(
                    AppLocalizations.of(context)!.enterPassword,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3,
                  ),
                ),
                actions: [
                  Center(
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          //Password Widget
                          passwordWidget(
                            context: context,
                            validator: passwordValidation,
                            hintText: AppLocalizations.of(context)!.password,
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
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 42, vertical: 12),
                        child: Text(
                          AppLocalizations.of(context)!.enter,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
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
          border: Border.all(color: Theme
              .of(context)
              .primaryColor),
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

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    } else if (value != password) {
      return AppLocalizations.of(context)!.passwordDoesNotMatch;
    }
    return null;
  }

  Padding passwordWidget({required BuildContext context,
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
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
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

  void validate() {
    if (_registerFormKey.currentState?.validate() == true) {}
    onPressed: () {};
  }
}