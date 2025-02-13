part of 'user_controller.dart';

Future<Map<String, dynamic>> implDeleteUserDoc2({
  required FirebaseRepository2 firebaseRepository,
  required Usua user,
  required String fileName,
}) async {
  // Delete file from Firebase Storage

  final String filePath = 'arquivos/${user.id}/$fileName';

  final deleteDocResponse =
      await firebaseRepository.deleteFile(filePath: filePath);

  if (!deleteDocResponse['success']) {
    return deleteDocResponse;
  }

  // Update Firestore collection after deletion

  user.deleteUserDoc(fileName);

  // Update the 'docs' field for the user in Firestore
  final updateUserDataResponse = await firebaseRepository.updateUserData2(
    data: {'docs': user.docs},
    userId: user.id,
  );

  if (!updateUserDataResponse['success']) {
    return updateUserDataResponse;
  }

  return {'success': true, 'message': 'Documento excluido com sucesso!'};
}
