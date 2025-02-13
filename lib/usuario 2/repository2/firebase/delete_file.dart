part of 'firebase_repository.dart';

Future<Map<String, dynamic>> implDeleteFile2({required String filePath}) async {
  try {
    await FirebaseStorage.instance.ref(filePath).delete();

    return {
      'success': true,
      'message': 'Arquivo excluido com sucesso!',
    };
  } on FirebaseException catch (e) {
    return {
      'success': false,
      'message': getFirebaseException(e.code),
    };
  }
}
