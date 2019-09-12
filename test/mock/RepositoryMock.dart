import 'package:flutter_messenger/repositories/AuthenticationRepository.dart';
import 'package:flutter_messenger/repositories/StorageRepository.dart';
import 'package:flutter_messenger/repositories/UserDataRepository.dart';
import 'package:mockito/mockito.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository{}
class UserDataRepositoryMock extends Mock implements UserDataRepository{}
class StorageRepositoryMock extends Mock implements StorageRepository{}