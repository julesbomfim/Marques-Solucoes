import 'package:file_picker/file_picker.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/repository/firebase/firebase_repository.dart';

part 'delete_user_doc.dart';
part 'insert_user_doc.dart';

class UserController {
  final firebaseRepository = FirebaseRepository();

  Future<Map<String, dynamic>> insertUserDocs({
    required Usua user,
    required List<PlatformFile> files,
  }) async =>
      implInsertUserDoc(
          firebaseRepository: firebaseRepository, user: user, files: files);

  Future<Map<String, dynamic>> deleteUserDoc({
    required Usua user,
    required String fileName,
  }) async =>
      implDeleteUserDoc(
          firebaseRepository: firebaseRepository,
          user: user,
          fileName: fileName);
}
