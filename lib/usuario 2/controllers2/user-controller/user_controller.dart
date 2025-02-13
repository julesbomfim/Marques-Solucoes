import 'package:file_picker/file_picker.dart';
import 'package:flutter_web/dados/user.dart';

import '../../repository2/firebase/firebase_repository.dart';

part 'delete_user_doc.dart';
part 'insert_user_doc.dart';

class UserController2 {
  final firebaseRepository = FirebaseRepository2();

  Future<Map<String, dynamic>> insertUserDocs2({
    required Usua user,
    required List<PlatformFile> files,
  }) async =>
      implInsertUserDoc2(
          firebaseRepository: firebaseRepository, user: user, files: files);

  Future<Map<String, dynamic>> deleteUserDoc2({
    required Usua user,
    required String fileName,
  }) async =>
      implDeleteUserDoc2(
          firebaseRepository: firebaseRepository,
          user: user,
          fileName: fileName);
}
