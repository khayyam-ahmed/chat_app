import 'dart:io';

import 'package:chat_app/utils/constants/image_strings.dart';
import 'package:chat_app/utils/constants/sizes.dart';
import 'package:chat_app/utils/constants/text_strings.dart';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  var _username = '';
  var _isLogin = true;
  File? _pickedImageFile;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || (!_isLogin && _pickedImageFile == null)) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isAuthenticating = true;
    });

    try {
      if (_isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        final userRefInFbSt = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');
        await userRefInFbSt.putFile(_pickedImageFile!);
        final imgUrl = await userRefInFbSt.getDownloadURL();
        final userRefInFbFs = FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid);
        await userRefInFbFs.set({
          'username': _username,
          'email': _email,
          'image_url': imgUrl,
        });
      }
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
        setState(() {
          _isAuthenticating = false;
        });
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
                          if (!_isLogin)
                            UserImagePicker(
                              onPickImage: (pickedImage) =>
                                  _pickedImageFile = pickedImage,
                            ),
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
                            onSaved: (email) => _email = email!.trim(),
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: TText.usernameHintText,
                                labelText: TText.usernameLabelText,
                              ),
                              enableSuggestions: false,
                              textCapitalization: TextCapitalization.words,
                              validator: (username) {
                                return TText.getUsernameValidatorText(username);
                              },
                              onSaved: (username) =>
                                  _username = username!.trim(),
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
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              onPressed: () => _submit(),
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                            ),
                          if (!_isAuthenticating)
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
