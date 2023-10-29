import 'package:chat_app/utils/constants/image_strings.dart';
import 'package:chat_app/utils/constants/sizes.dart';
import 'package:chat_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _password = '';
  var _email = '';
  var _isLogin = true;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (_isLogin) {
      try {
        // final userCredenial =
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
      } on FirebaseAuthException catch (error) {
        var message = 'An error occurred, please check your credentials!';
        if (error.message != null) {
          message = error.message!;
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: TSizes.authScreenLogoMargin,
                child: Image.asset(
                  TImages.appLogo,
                  width: 200,
                ),
              ),
              Card(
                margin: TSizes.generalMargin,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: TSizes.generalPadding,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: TText.emailHintText,
                              labelText: TText.emailLabelText,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (email) {
                              return TText.getEmailValidatorText(email);
                            },
                            onSaved: (email) => _email = email!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: TText.passwordHintText,
                              labelText: TText.passwordLabelText,
                            ),
                            obscureText: true,
                            validator: (password) {
                              return TText.getPasswordValidatorText(password);
                            },
                            onSaved: (password) => _password = password!,
                          ),
                          const SizedBox(height: TSizes.generalSizedBoxHeight),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            onPressed: () => _submit(),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create new account'
                                : 'I already have an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
