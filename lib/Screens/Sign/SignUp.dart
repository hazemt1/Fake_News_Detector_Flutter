import 'package:fake_news/Widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();
  String userName = '';

  String email = '';

  String password = '';
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          AppLocalizations.of(context)!.signUp,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(
          height: 25,
        ),
        Form(
          key: _registerFormKey,
          child: Column(
            children: [
              //Name Widget
              formTextField(
                context: context,
                field: "username",
                hintText: AppLocalizations.of(context)!.name,
                validator: usernameValidation,
              ),
              //Email Widget
              formTextField(
                context: context,
                field: "email",
                hintText: AppLocalizations.of(context)!.email,
                validator: usernameValidation,
              ),

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
                hintText: AppLocalizations.of(context)!.confirmPassword,
                field: "confirm password",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: createAccount,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
            child: Text(
              AppLocalizations.of(context)!.register,
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

  Widget formTextField(
      {required BuildContext context,
      required Function validator,
      required hintText,
      required String field}) {
    return customPadding(
      child: TextFormField(
        onChanged: (value) {
          if (field == "userName") {
            userName = value;
          } else if (field == "email") {
            email = value;
          }
        },
        validator: (t) => validator(t),
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.subtitle1,
            border: InputBorder.none),
      ),
    );
  }

  String? usernameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterName;
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    }
    return null;
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

  void createAccount() {
    if (_registerFormKey.currentState?.validate() == true) {}
  }
}
