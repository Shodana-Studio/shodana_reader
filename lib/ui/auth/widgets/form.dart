import 'package:dartz/dartz.dart' as dz;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart' as flutter_signin_button;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart' as sign_button;

import '../../../core/commands/account/login_command.dart';
import '../../../core/commands/account/oauth_login_command.dart';
import '../../../core/commands/account/signup_command.dart';
import '../../../core/data/failure.dart';
import '../../../core/service/authnotifier_extension.dart';
import '../../../l10n/my.i18n.dart';
import '../signup_screen.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key, required this.controller, required this.focusNode}) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: !kIsWeb ? [AutofillHints.username] : null,
      keyboardType: TextInputType.name,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
          labelText: 'Username'.i18n,
          border: const OutlineInputBorder(),
          // hintText: 'beamer'
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.controller, required this.focusNode}) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: !kIsWeb ? [AutofillHints.email] : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) => !EmailValidator.validate(val!, true)
        ? 'Not a valid email.'
        : null,
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
          labelText: 'Email'.i18n,
          border: const OutlineInputBorder(),
          // hintText: 'beamer'
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key, required this.controller, required this.focusNode}) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: !kIsWeb ? [AutofillHints.password] : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null){
          return null;
        }
        if (value.length < 6 || value.length > 32) {
          return 'Must be between 6 and 32 characters';
        }
      },
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.done,
      obscureText: _isHidden,
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: 'Password'.i18n,
          border: const OutlineInputBorder(),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                _isHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ), // myIcon is a 48px-wide widget.
          ),
          // hintText: 'supersecret'
      ),
    );
  }
}

class SignInWithGithub extends ConsumerWidget {
  const SignInWithGithub({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return sign_button.SignInButton(
      buttonType: sign_button.ButtonType.github,
      onPressed: () async {    
        final dz.Either<Failure, bool> result = await ref.read(oAuthLoginCommandProvider).run(provider: OAuth.github);

        result.fold(
          (failure) {
            // If login fails, notify the user
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: Text(failure.message, style: Theme.of(context).snackBarTheme.contentTextStyle),
            ));

            debugPrint(failure.message);
          },
          (success) => null
        );
      },
    );
  }
}

class SignInWithDiscord extends ConsumerWidget {
  const SignInWithDiscord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return flutter_signin_button.SignInButtonBuilder(
      backgroundColor: const Color.fromRGBO(64, 78, 237, 1),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(90.0), right: Radius.circular(90.0))),
      text: 'Sign in with Discord'.i18n,
      onPressed: () async {
        final dz.Either<Failure, bool> result = await ref.read(oAuthLoginCommandProvider).run(provider: OAuth.discord);

        result.fold(
          (failure) {
            // If login fails, notify the user
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: Text(failure.message, style: Theme.of(context).snackBarTheme.contentTextStyle),
            ));

            debugPrint(failure.message);
          },
          (success) => null
        );
      },
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton(
      {Key? key,
        required this.emailController,
        required this.passwordController})
      : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final email = emailController.text;
          final password = passwordController.text;
          final dz.Either<Failure, bool> result = await ref.read(loginCommandProvider).run(context: context, email: email, password: password);

          result.fold(
            (failure) {
              // If login fails, notify the user
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
                content: Text(failure.message, style: Theme.of(context).snackBarTheme.contentTextStyle),
              ));

              debugPrint(failure.message);
            },
            (success) => null
          );
        },
        child: Text('Login'.i18n),
      ),
    );
  }
}


class GoToSignupButton extends StatelessWidget {
  const GoToSignupButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => const SignupScreen(),
          ));
        },
        child: Text('Not registered? Sign up.'.i18n),
      ),
    );
  }
}

class SignupButton extends ConsumerWidget {
  const SignupButton(
      {Key? key,
        required this.usernameController,
        required this.emailController,
        required this.passwordController})
      : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final username = usernameController.text;
          final email = emailController.text;
          final password = passwordController.text;

          
          final dz.Either<Failure, bool> result = await ref.read(signupCommandProvider).run(context: context, username: username, email: email, password: password);

          result.fold(
            (failure) {
              // If login fails, notify the user
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
                content: Text(failure.message, style: Theme.of(context).snackBarTheme.contentTextStyle),
              ));

              debugPrint(failure.message);
            },
            (success) {
              // Signup successful
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
                content: Text('Successfully signed up.'.i18n),
              ));
              Navigator.pop(context);
            }
          );
        },
        child: Text('Signup'.i18n),
      ),
    );
  }
}