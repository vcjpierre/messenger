import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_messenger/blocs/chats/Bloc.dart';
import 'package:flutter_messenger/config/Constants.dart';
import 'package:flutter_messenger/config/Paths.dart';
import 'package:flutter_messenger/models/Message.dart';
import 'package:flutter_messenger/repositories/ChatRepository.dart';
import 'package:flutter_messenger/repositories/StorageRepository.dart';
import 'package:flutter_messenger/repositories/UserDataRepository.dart';
import 'package:flutter_messenger/utils/Exceptions.dart';
import 'package:flutter_messenger/utils/SharedObjects.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final UserDataRepository userDataRepository;
  final StorageRepository storageRepository;
  StreamSubscription subscription;

  ChatBloc(
      {this.chatRepository, this.userDataRepository, this.storageRepository})
      : assert(chatRepository != null),
        assert(userDataRepository != null),
        assert(storageRepository != null);

  @override
  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    print(event);
    if (event is FetchMessagesEvent) {
      mapFetchMessagesEventToState(event);
    }
    if (event is ReceivedMessagesEvent) {
      print(event.messages);
      yield FetchedMessagesState(event.messages);
    }
    if (event is SendTextMessageEvent) {
      await chatRepository.sendMessage(event.chatId, event.message);
    }
    if (event is PickedAttachmentEvent) {
      await mapPickedAttachmentEventToState(event);
    }
  }

  Stream<ChatState> mapFetchMessagesEventToState(FetchMessagesEvent event) async* {
    try {
      yield InitialChatState();
      subscription?.cancel();
      subscription = chatRepository
          .getMessages(event.chatId)
          .listen((messages) => dispatch(ReceivedMessagesEvent(messages)));
    } on MessengerException catch (exception) {
      print(exception.errorMessage());
      yield ErrorState(exception);
    }
  }

  Future mapPickedAttachmentEventToState(PickedAttachmentEvent event) async {
    String url = await storageRepository.uploadFile(
        event.file, Paths.imageAttachmentsPath);
    String username = SharedObjects.prefs.getString(Constants.sessionUsername);
    String name = SharedObjects.prefs.getString(Constants.sessionName);
    Message message = VideoMessage(
        url, DateTime.now().millisecondsSinceEpoch, name, username);
    await chatRepository.sendMessage(event.chatId, message);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
