import 'package:equatable/equatable.dart';
import 'package:flutter_messenger/models/Contact.dart';
import 'package:flutter_messenger/utils/Exceptions.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsState extends Equatable {
  ContactsState([List props = const <dynamic>[]]) : super(props);
}

class InitialContactsState extends ContactsState {
  @override
  String toString() => 'InitialContactsState';
}
class FetchingContactsState extends ContactsState{
  @override
  String toString() => 'FetchingContactsState';
}
class FetchedContactsState extends ContactsState {
  final List<Contact> contacts;

  FetchedContactsState(this.contacts);
  @override
  String toString() => 'FetchedContactsState';
}

class ShowAddContactState extends ContactsState {
  @override
  String toString() => 'ShowAddContactState';
}

class AddContactProgressState extends ContactsState {
  @override
  String toString() => 'AddContactProgressState';
}

class AddContactSuccessState extends ContactsState {
  @override
  String toString() => 'AddContactSuccessState';
}

class AddContactFailedState extends ContactsState {
  final MessengerException exception;
  AddContactFailedState(this.exception);
  @override
  String toString() => 'AddContactFailedState';
}

class ClickedContactState extends ContactsState {
  @override
  String toString() => 'ClickedContactState';
}

class ErrorState extends ContactsState {
  final MessengerException exception;
  ErrorState(this.exception);
  @override
  String toString() => 'ErrorState';
}
