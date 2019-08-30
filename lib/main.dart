import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messenger/pages/ConversationPageSlide.dart';
import 'package:flutter_messenger/repositories/AuthenticationRepository.dart';
import 'package:flutter_messenger/repositories/StorageRepository.dart';
import 'package:flutter_messenger/repositories/UserDataRepository.dart';
import 'config/Palette.dart';
import 'pages/RegisterPage.dart';
import 'blocs/authentication/Bloc.dart';

void main() {
  //create instances of the repositories to supply them to the app
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(
          authenticationRepository: authRepository,
          userDataRepository: userDataRepository,
          storageRepository: storageRepository)
        ..dispatch(AppLaunched()),
      child: FlutterMessenger(),
    ),
  );
}

class FlutterMessenger extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterMessenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return RegisterPage();
          } else if (state is ProfileUpdated) {
            return ConversationPageSlide();
          } else {
            return RegisterPage();
          }
        },
      ),
    );
  }
}
