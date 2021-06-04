import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sign_button/sign_button.dart' as sign_button;
import 'package:flutter_signin_button/flutter_signin_button.dart' as flutter_signin_button;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   late TextEditingController _email;
//   late TextEditingController _password;
//
//   @override
//   void initState() {
//     super.initState();
//     _email = TextEditingController();
//     _password = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             const SizedBox(height: 30.0),
//             Text(
//               'Shodana Reader',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headline3?.copyWith(
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             Card(
//               margin: const EdgeInsets.all(32.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: ListView(
//                 shrinkWrap: true,
//                 primary: false,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: const EdgeInsets.all(16.0),
//                 children: [
//                   const SizedBox(height: 20.0),
//                   Text(
//                     'Login Required',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headline5?.copyWith(
//                       color: Colors.red,
//                     ),
//                   ),
//                   const SizedBox(height: 10.0),
//                   Text(
//                     'Online features require an account to use.',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.subtitle1,
//                   ),
//                   const SizedBox(height: 20.0),
//                   TextField(
//                     controller: _email,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter email',
//                     ),
//                   ),
//                   TextField(
//                     controller: _password,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter password',
//                     ),
//                   ),
//                   const SizedBox(height: 30.0),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final email = _email.text;
//                       final password = _password.text;
//
//                       if (!(await context.authNotifier?.createSession(
//                           email: email, password: password) ??
//                           false)) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: Text(context.authNotifier?.error ??
//                                 'Unknown error')));
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.all(16.0),
//                     ),
//                     child: const Text('Login'),
//                   ),
//                   const SizedBox(height: 20.0),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LoadingPage extends StatelessWidget {
//   const LoadingPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }


class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final FocusNode focusNode1 = useFocusNode();
    final FocusNode focusNode2 = useFocusNode();
    // final authNotifier = context.authNotifier;

    
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 256),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: [
                const FlutterLogo(size: 128),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline2,
                ),
                // const SignInWithGithub(),
                // const SignInWithDiscord(),
                EmailInput(controller: emailController, focusNode: focusNode1,),
                PasswordInput(controller: passwordController, focusNode: focusNode2,),
                LoginButton(
                    emailController: emailController,
                    passwordController: passwordController
                ),
                const GoToSignupButton(),
                // Text('STATE: ${authNotifier?.status ?? AuthStatus
                //     .uninitialized}'),
                // if ((authNotifier?.status ?? AuthStatus.uninitialized)
                // == AuthStatus.authenticating)
                //   const CircularProgressIndicator()
              ],
            ),
          ),
        ),
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
      decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
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
          labelText: 'Password',
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

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
        required this.emailController,
        required this.passwordController})
      : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final email = emailController.text;
          final password = passwordController.text;

          if ( !(await context.authNotifier?.createSession(
              email: email, password: password) ?? false) ) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: Text(context.authNotifier?.error ??
                  'Unknown error', style: Theme.of(context).snackBarTheme.contentTextStyle),
            ));
            debugPrint(context.authNotifier?.error ??
                'Unknown error');
          }
        },
        child: const Text('Login'),
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
            builder: (_) => const SignupPage(),
          ));
        },
        child: const Text('Not registered? Sign up.'),
      ),
    );
  }
}


class SignupPage extends HookWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final FocusNode focusNode1 = useFocusNode();
    final FocusNode focusNode2 = useFocusNode();
    final FocusNode focusNode3 = useFocusNode();
    // final authNotifier = context.authNotifier;

    
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 256),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: [
                const FlutterLogo(size: 128),
                Text(
                  'Signup',
                  style: Theme.of(context).textTheme.headline2,
                ),
                UsernameInput(controller: usernameController, focusNode: focusNode1,),
                EmailInput(controller: emailController, focusNode: focusNode2,),
                PasswordInput(controller: passwordController, focusNode: focusNode3,),
                SignupButton(
                  usernameController: usernameController,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                // Text('STATE: ${authNotifier?.status ?? AuthStatus
                //     .uninitialized}'),
                // if ((authNotifier?.status ?? AuthStatus.uninitialized)
                // == AuthStatus.authenticating)
                //   const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInWithGithub extends StatelessWidget {
  const SignInWithGithub({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sign_button.SignInButton(
      buttonType: sign_button.ButtonType.github,
      onPressed: () async {
        if ( !(await context.authNotifier?.createOAuth2Session(provider: 'google') ?? false) ) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(context.authNotifier?.error ??
                'Unknown error', style: Theme.of(context).snackBarTheme.contentTextStyle),
          ));
          debugPrint(context.authNotifier?.error ??
              'Unknown error');
        }
      },
    );
  }
}

class SignInWithDiscord extends StatelessWidget {
  const SignInWithDiscord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return flutter_signin_button.SignInButtonBuilder(
      backgroundColor: const Color.fromRGBO(64, 78, 237, 1),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(90.0), right: Radius.circular(90.0))),
      text: 'Sign in with Discord',
      onPressed: () async {
        if ( !(await context.authNotifier?.createOAuth2Session(provider: 'google') ?? false) ) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: Text(context.authNotifier?.error ??
                'Unknown error', style: Theme.of(context).snackBarTheme.contentTextStyle),
          ));
          debugPrint(context.authNotifier?.error ??
              'Unknown error');
        }
      },
    );
  }
}

class SignupButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final username = usernameController.text;
          final email = emailController.text;
          final password = passwordController.text;

          if ( !(await context.authNotifier?.create(name: username, email: email, password: password) ?? false) ) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: Text(context.authNotifier?.error ??
                  'Unknown error', style: Theme.of(context).snackBarTheme.contentTextStyle),
            ));
            debugPrint(context.authNotifier?.error ??
                'Unknown error');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: const Text('Successfully signed up.'),
            ));
            Navigator.pop(context);
          }
        },
        child: const Text('Signup'),
      ),
    );
  }
}

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
      decoration: const InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(),
          // hintText: 'beamer'
      ),
    );
  }
}