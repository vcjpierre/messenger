import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messenger/blocs/attachments/AttachmentsBloc.dart';
import 'package:flutter_messenger/blocs/chats/Bloc.dart';
import 'package:flutter_messenger/blocs/config/Bloc.dart';
import 'package:flutter_messenger/blocs/contacts/Bloc.dart';
import 'package:flutter_messenger/blocs/home/Bloc.dart';
import 'package:flutter_messenger/config/Constants.dart';
import 'package:flutter_messenger/config/Themes.dart';
import 'package:flutter_messenger/pages/HomePage.dart';
import 'package:flutter_messenger/repositories/AuthenticationRepository.dart';
import 'package:flutter_messenger/repositories/ChatRepository.dart';
import 'package:flutter_messenger/repositories/StorageRepository.dart';
import 'package:flutter_messenger/repositories/UserDataRepository.dart';
import 'package:flutter_messenger/utils/SharedObjects.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/authentication/Bloc.dart';
import 'pages/RegisterPage.dart';

void main() async {
  //create instances of the repositories to supply them to the app
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  final ChatRepository chatRepository = ChatRepository();
  SharedObjects.prefs = await CachedSharedPreferences.getInstance();
  Constants.cacheDirPath = (await getTemporaryDirectory()).path;
  Constants.downloadsDirPath =
      (await DownloadsPathProvider.downloadsDirectory).path;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        builder: (context) => AuthenticationBloc(
            authenticationRepository: authRepository,
            userDataRepository: userDataRepository,
            storageRepository: storageRepository)
          ..dispatch(AppLaunched()),
      ),
      BlocProvider<ContactsBloc>(
        builder: (context) => ContactsBloc(
            userDataRepository: userDataRepository,
            chatRepository: chatRepository),
      ),
      BlocProvider<ChatBloc>(
        builder: (context) => ChatBloc(
            userDataRepository: userDataRepository,
            storageRepository: storageRepository,
            chatRepository: chatRepository),
      ),
      BlocProvider<AttachmentsBloc>(
        builder: (context) => AttachmentsBloc(chatRepository: chatRepository),
      ),
      BlocProvider<HomeBloc>(
        builder: (context) => HomeBloc(chatRepository: chatRepository),
      ),
      BlocProvider<ConfigBloc>(
        builder: (context) => ConfigBloc(storageRepository: storageRepository,userDataRepository: userDataRepository),
      )
    ],
    child: Messenger(),
  ));
}

// ignore: must_be_immutable
class Messenger extends StatefulWidget {
  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  ThemeData theme;
  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
      if (state is UnConfigState) {
        theme = SharedObjects.prefs.getBool(Constants.configDarkMode)
            ? Themes.dark
            : Themes.light;
      }
      if(state is RestartedAppState){
        key = UniqueKey();
      }
      if (state is ConfigChangeState && state.key == Constants.configDarkMode) {
        theme = state.value ? Themes.dark : Themes.light;
      }
      return MaterialApp(
        title: 'Messenger',
        theme: theme,
        key: key,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is UnAuthenticated) {
              return RegisterPage();
            } else if (state is ProfileUpdated) {
              if(SharedObjects.prefs.getBool(Constants.configMessagePaging))
                BlocProvider.of<ChatBloc>(context).dispatch(FetchChatListEvent());
              return HomePage();
            } else {
              return RegisterPage();
            }
          },
        ),
      );
    });
  }
}
