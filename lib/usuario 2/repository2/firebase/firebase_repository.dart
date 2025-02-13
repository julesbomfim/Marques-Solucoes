import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_web/helper/firebase_firebase_exception.dart';

part 'delete_file.dart';
part 'update_user_data.dart';
part 'insert_user_doc.dart';

class FirebaseRepository2 {
  Future<Map<String, dynamic>> deleteFile({required String filePath}) async =>
      implDeleteFile2(filePath: filePath);

  Future<Map<String, dynamic>> updateUserData2({
    required Map<String, dynamic> data,
    required String userId,
  }) async =>
      implUpdateUserData2(data: data, userId: userId);

  Future<Map<String, dynamic>> insertUserDoc2({
    required String fileName,
    required String userId,
    required Uint8List fileBytes,
  }) async =>
      implInsertUserDoc2(
          fileName: fileName, userId: userId, fileBytes: fileBytes);
}
