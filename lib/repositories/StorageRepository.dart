import 'dart:io';

import 'package:flutter_messenger/providers/StorageProvider.dart';
import 'package:flutter_messenger/repositories/BaseRepository.dart';

class StorageRepository extends BaseRepository{
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadFile(File file, String path) => storageProvider.uploadFile(file, path);

  @override
  void dispose() {
storageProvider.dispose();
  }
}