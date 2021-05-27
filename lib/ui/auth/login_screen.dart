import 'package:flutter/material.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 30.0),
            Text(
              'Appwrite Auth Provider Example',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              margin: const EdgeInsets.all(32.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                children: [
                  const SizedBox(height: 20.0),
                  Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Enter email',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter password',
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;

                      if (!(await context.authNotifier?.createSession(
                          email: email, password: password) ??
                          false)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(context.authNotifier?.error ??
                                'Unknown error')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}