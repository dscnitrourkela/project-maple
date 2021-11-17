# APTICHE TECHNICAL GUIDE

AptiChe is an initiative by the **AIChE NITR student chapter in association with Google Developers Students Club, NITR** to provide an opportunity to the students to practice and showcase their aptitude and reasoning skills.
This project uses the [GetX](https://pub.dev/packages/get) for State Management and Local Storage, [Firebase](https://pub.dev/packages/firebase_auth) for authentication and [GraphQL](https://pub.dev/packages/graphql_flutter) for the GraphQL Client.

## Installation Guide

1. **Install Flutter on your machine**

    Install flutter by selecting the operating system on which you are installing Flutter: [Flutter installation tutorial](https://flutter.dev/docs/get-started/install)

    To check if you have flutter installed along wtih proper necesarry SDKs installed
    run `flutter doctor`

2. **Fork and Clone the Repo**

    Fork the repo by clicking on the **Fork** button on the top right corner of the page.
    To clone this repository, run `git clone https://github.com/dscnitrourkela/project-maple.git`
    Then run `cd project-maple`

3. **Get Packages**

     Make sure you are in the `project-maple/aptiche` directory

    - From the terminal: Run `flutter pub get`.

      _OR_
    - From Android Studio/IntelliJ: **Click Packages get** in the action ribbon at the top of `pubspec.yaml`.
    - From VS Code: **Click Get Packages** located in right side of the action ribbon at the top of `pubspec.yaml`.

    After the above steps, you should see the following: `pub get suceessful with exit code 0`

## Run the App

  On terminal:

- Check that an Android device is running by running `flutter devices`. If none are shown, follow the device-specific instructions on the [Install](https://flutter.dev/docs/get-started/install) page for your OS.
- Run the app with the following command: `flutter run`
- If you want to contibute and have an idea, open an issue, and mention the admin for getting the `google-services.json` file.

Congrats ! You just ran the _Project Maple_.
Feel free to use the application in whatever way possible and make sure to send us feedbacks and suggest changes.

## Libraries & Tools Used

- [Lottie](https://pub.dev/packages/lottie)
- [Firebase Auth](https://pub.dev/packages/firebase_auth)
- [GraphQL](https://pub.dev/packages/graphql_flutter)
- [GetX](https://pub.dev/packages/get)
- [Firebase Remote Config](https://pub.dev/packages/firebase_remote_config)
- [URL Launcher](https://pub.dev/packages/url_launcher)
- [Dart Doc](https://pub.dev/packages/dart_doc)

### Folder Structure

Here is the core folder structure which flutter provides.

``` markdown
aptiche/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

``` markdown
lib/
|- datamodels/
|- services/
|- utils/
|- views/
|- widgets/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

``` markdown
1- utils - All the application level constants are defined in this directory with-in their respective files. 
          This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.

2- datamodels - Contains the data layer of your project, includes directories for local, network and shared pref/cache.

3- services - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI.  
              This directory contains the services for `auth`, `remote config`, `graphql` and `preferences`.

4- view — Contains all the ui of your project, contains sub directory for each screen.

5- widgets — Contains the common widgets for your applications. For example, Button, Snackbar etc.

6- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

Explore the repository and contribute to `Project Maple` according to the [Contributing Guidelines](./CONTRIBUTING.md) and the [Code of Conduct](./CODE_OF_CONDUCT.md) for the project.
