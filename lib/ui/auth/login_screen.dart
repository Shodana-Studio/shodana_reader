import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    // final authNotifier = context.authNotifier;

    
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 256),
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
              EmailInput(controller: emailController),
              PasswordInput(controller: passwordController),
              LoginButton(
                  usernameController: emailController,
                  passwordController: passwordController),
              // Text('STATE: ${authNotifier?.status ?? AuthStatus
              //     .uninitialized}'),
              // if ((authNotifier?.status ?? AuthStatus.uninitialized)
              // == AuthStatus.authenticating)
              //   const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: !kIsWeb ? [AutofillHints.email] : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) => !EmailValidator.validate(val!, true)
        ? 'Not a valid email.'
        : null,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          // hintText: 'beamer'
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

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
      obscureText: true,
      controller: controller,
      decoration: const InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          // hintText: 'supersecret'
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
        required this.usernameController,
        required this.passwordController})
      : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final email = usernameController.text;
          final password = passwordController.text;

          if ( !(await context.authNotifier?.createSession(
              email: email, password: password) ?? false) ) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
              content: Text(context.authNotifier?.error ??
                  'Unknown error', style: Theme.of(context).snackBarTheme.contentTextStyle),
            ));
            print(context.authNotifier?.error ??
                'Unknown error');
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}