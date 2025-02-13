part of 'firebase_repository.dart';

Future<Map<String, dynamic>> implInsertUserDoc2({
  required String fileName,
  required String userId,
  required Uint8List fileBytes,
}) async {
  try {
    await FirebaseStorage.instance
        .ref('arquivos/$userId/$fileName')
        .putData(fileBytes);

    return {
      'success': true,
      'message': 'Arquivo inserido com sucesso!',
    };
  } on FirebaseException catch (e) {
    return {
      'success': false,
      'message': e.message,
    };
  }
}
