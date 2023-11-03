# FLUTTER CHAT_APP
A guided project to learn user authentication, and push notifications. Following udemy course [Flutter & Dart - The Complete Guide](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/) by Maximillian Schwarzmüller.
The original project source code can be found [here](https://github.com/academind/flutter-complete-guide-course-resources/tree/main/Code%20Snapshots/14%20Chat%20App).

**Disclaimer**:
 - This project was for learning purposes.
 - And this is not a replica of Maximillian's actuall project, which you can find <a href = 'https://github.com/academind/flutter-complete-guide-course-resources/tree/main/Code%20Snapshots/14%20Chat%20App'>here</a>
  - I have made some changes to the UI and the code structure.

Chat App is a basic chat application built using Flutter and Firebase for various backend features. This app allows users to send and receive messages in real-time, authenticate users, store user data, and send push notifications. Whether you want to explore how real-time messaging and user authentication work in Flutter or build your chat application, this project serves as a great starting point.

# Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)

# Features

- **Authentication**: Users can create accounts or log in using their email and password. Firebase Authentication is used for user authentication.
    ```dart
    // Authentication with Firebase
    await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    ```
- **Real-time Messaging**: Chat messages are sent and received in real-time using Firebase Cloud Firestore. Messages are ordered by creation time and displayed in a chat interface.
    ```dart
    // Send message to Firestore
    await _firestore.collection('chat').add({
        'text': message,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': user.displayName,
        'userImage': user.photoURL,
    });
    ```
- **Image Upload**: Users can upload profile images during account creation, and these images are stored in Firebase Storage.
    ```dart
    // Upload image to Firebase Storage
    final userRefInFbSt = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${userCredential.user!.uid}.jpg');
    await userRefInFbSt.putFile(_pickedImageFile!);
    ```
- **Push Notifications**: The app supports push notifications using Firebase Cloud Messaging (FCM). Users are subscribed to the 'chat' topic for notifications.
    ```dart
    // Subscribing to the 'chat' topic for push notifications
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
    ```

# Project Structure
The project structure is organized as follows:
```yaml
chat_app:
  lib:
    screens:
      auth.dart
      chat.dart
      splash_screen.dart
    utils:
      constants:
        colors.dart
        image_strings.dart
        sizes.dart
        text_strings.dart
      themes:
        theme.dart
    widgets:
      chat_messages.dart
      new_message.dart
      image_picker.dart
      message_bubble.dart
    app.dart
    firebase_options.dart
    main.dart
  pubspec.yaml
  README.md
```
# Dependencies
The project relies on the following dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  firebase_core: ^2.20.0
  firebase_auth: ^4.12.0
  firebase_storage: ^11.4.0
  image_picker: ^1.0.4
  cloud_firestore: ^4.12.1
  firebase_messaging: ^14.7.3
```
# Getting Started
To get started with this project, follow these steps:
1. Clone the project to your local machine.
    ```bash
    git clone https://github.com/khayyam-ahmed/chat_app.git
    ```
2. Install the Firebase SDK: Make sure you have the Firebase CLI installed, and create a new project on the Firebase console. Follow the Firebase documentation for setup instructions.

3. Activate Authentication, Database, and Storage services in your Firebase project. Follow the Firebase documentation for setup instructions.

    - Firebase Authentication
    - Firebase Realtime Database
    - Firebase Storage

4. Install the FlutterFire CLI:
    ```bash
    flutter pub global activate flutterfire_cli
    ```
5. Login to Firebase using the CLI:
    ```bash
    flutterfire login
    ```
6. Add your Firebase project to the FlutterFire CLI:
    ```bash
    flutterfire init
    ```
7. Select the Firebase project you created in step 2.
8. Select the Firebase services you activated in step 3.
9. Configure the Firebase services using the CLI:
    ```bash
    flutterfire configure
    ```
10. Install all of the project dependencies
    ```bash
    flutter pub get
    ```
11. Run the app on your device or emulator:
    ```bash
    flutter run
    ```
Now you're ready to go. 🥳🥳🥳

Feel free to customize the app further according to your needs.

Happy coding!
# Screenshots
<tr>
<td><img src="../assets/screenshots/auth_screen.png" width="360" height="820">></td>
<td><img src="../assets/screenshots/chat_screen.png" width="360" height="820">></td>
</tr>


# Credits
- [Maximillian Schwarzmüller](https://www.udemy.com/user/maximilian-schwarzmuller/)