part of 'user_controller.dart';

Future<Map<String, dynamic>> implInsertUserDoc3({
  required FirebaseRepository3 firebaseRepository,
  required Usua user,
  required List<PlatformFile> files,
}) async {
  await Future.wait(files.map((file) async {
    final String fileName = file.name;

    final insertUserDocResponse = await firebaseRepository.insertUserDoc3(
      fileName: fileName,
      userId: user.id,
      fileBytes: file.bytes!.buffer.asUint8List(),
    );

    if (!insertUserDocResponse['success']) {
      return insertUserDocResponse;
    }

    user.addUserDoc(fileName);

    final updateUserDataResponse = await firebaseRepository.updateUserData3(
      data: {'docs': user.docs},
      userId: user.id,
    );

    if (!updateUserDataResponse['success']) {
      return updateUserDataResponse;
    }
  }));

  return {'success': true, 'message': 'Documento inserido com sucesso!'};
}
