import 'package:file_picker/file_picker.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/usuario%203/repository3/firebase/firebase_repository.dart';

part 'delete_user_doc.dart';
part 'insert_user_doc.dart';

class UserController3 {
  final firebaseRepository = FirebaseRepository3();

  Future<Map<String, dynamic>> insertUserDocs3({
    required Usua user,
    required List<PlatformFile> files,
  }) async =>
      implInsertUserDoc3(
          firebaseRepository: firebaseRepository, user: user, files: files);

  Future<Map<String, dynamic>> deleteUserDoc3({
    required Usua user,
    required String fileName,
  }) async =>
      implDeleteUserDoc3(
          firebaseRepository: firebaseRepository,
          user: user,
          fileName: fileName);
}
