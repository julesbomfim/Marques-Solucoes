import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_web/helper/firebase_firebase_exception.dart';

part 'delete_file.dart';
part 'update_user_data.dart';
part 'insert_user_doc.dart';

class FirebaseRepository {
  Future<Map<String, dynamic>> deleteFile({required String filePath}) async =>
      implDeleteFile(filePath: filePath);

  Future<Map<String, dynamic>> updateUserData({
    required Map<String, dynamic> data,
    required String userId,
  }) async =>
      implUpdateUserData(data: data, userId: userId);

  Future<Map<String, dynamic>> insertUserDoc({
    required String fileName,
    required String userId,
    required Uint8List fileBytes,
  }) async =>
      implInsertUserDoc(
          fileName: fileName, userId: userId, fileBytes: fileBytes);
}
