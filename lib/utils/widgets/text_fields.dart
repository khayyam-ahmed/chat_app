// import 'package:chat_app/utils/constants/text_strings.dart';
// import 'package:flutter/material.dart';

// class TTextFields {
//   // email field
//   static TextFormField emailTextFormField(Function setEmail) => TextFormField(
//         decoration: const InputDecoration(
//           hintText: TText.emailHintText,
//           labelText: TText.emailLabelText,
//         ),
//         keyboardType: TextInputType.emailAddress,
//         autocorrect: false,
//         textCapitalization: TextCapitalization.none,
//         validator: (value) {
//           if (value!.isEmpty || !value.contains('@')) {
//             return TText.emailValidatorText;
//           }
//           return null;
//         },
//         onSaved: (email) => setEmail(email),
//       );
//   // Password field
//   static TextFormField passwordTextFormField(Function setPassword) {
//     return TextFormField(
//       decoration: const InputDecoration(
//         hintText: TText.passwordHintText,
//         labelText: TText.passwordLabelText,
//       ),
//       obscureText: true,
//       validator: (password) {
//         return TText.getPasswordValidatorText(password);
//       },
//       onSaved: (password) {
//         setPassword(password);
//       },
//     );
//   }
// }
