import 'package:flutter_messenger/models/Chat.dart';
import 'package:flutter_messenger/models/Message.dart';
import 'package:flutter_messenger/providers/BaseProviders.dart';
import 'package:flutter_messenger/providers/ChatProvider.dart';

class ChatRepository{
  BaseChatProvider chatProvider = ChatProvider();
  Stream<List<Chat>> getChats() => chatProvider.getChats();
  Stream<List<Message>> getMessages(String chatId) => chatProvider.getMessages(chatId);
  Future<void> sendMessage(String chatId, Message message) => chatProvider.sendMessage(chatId, message);
}