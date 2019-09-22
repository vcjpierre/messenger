import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messenger/blocs/chats/Bloc.dart';
import 'package:flutter_messenger/config/Palette.dart';
import 'package:flutter_messenger/models/Chat.dart';
import 'package:flutter_messenger/widgets/ChatAppBar.dart';
import 'package:flutter_messenger/widgets/ChatListWidget.dart';

class ConversationPage extends StatefulWidget {
  final Chat chat;

  @override
  _ConversationPageState createState() => _ConversationPageState(chat);

  const ConversationPage(this.chat);
}

class _ConversationPageState extends State<ConversationPage> with AutomaticKeepAliveClientMixin{
  final Chat chat;

  _ConversationPageState(this.chat);

  ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    print('init of $chat');
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.dispatch(FetchConversationDetailsEvent(chat));
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build of $chat');
   // return Container(child: Center(child: Text(chat.username),),);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 100),
          color: Palette.chatBackgroundColor,
          child: ChatListWidget(chat),
        ),
        SizedBox.fromSize(
            size: Size.fromHeight(100),
            child: ChatAppBar(chat)
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

}
