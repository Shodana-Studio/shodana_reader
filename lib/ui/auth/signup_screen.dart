import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../l10n/my.i18n.dart';
import 'widgets/form.dart';

class SignupScreen extends HookWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
                  'Signup'.i18n,
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
                // Text('STATE: ${authNotifier.status}'),
                // if ((authNotifier.status)
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