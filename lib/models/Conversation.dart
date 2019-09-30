import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_messenger/config/Constants.dart';
import 'package:flutter_messenger/models/Message.dart';
import 'package:flutter_messenger/models/User.dart';
import 'package:flutter_messenger/utils/SharedObjects.dart';

class Conversation {
  String chatId;
  User user;
  Message latestMessage;

  Conversation(this.chatId, this.user, this.latestMessage);

  factory Conversation.fromFireStore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data;
    List<String> members = List.from(data['members']);
    String selfUsername =
        SharedObjects.prefs.getString(Constants.sessionUsername);
    User contact;
    for (int i = 0; i < members.length; i++) {
      if (members[i] != selfUsername) {
        final userDetails = Map<String,dynamic>.from((data['membersData'])[i]);
        contact = User.fromMap(userDetails);
      }
    }
    return Conversation(
        doc.documentID, contact, Message.fromMap(Map.from(data['latestMessage'])));
  }

  @override
  String toString() =>
      '{ user= $user, chatId = $chatId, latestMessage = $latestMessage}';
}
