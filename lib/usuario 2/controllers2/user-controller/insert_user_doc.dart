part of 'user_controller.dart';

Future<Map<String, dynamic>> implInsertUserDoc2({
  required FirebaseRepository2 firebaseRepository,
  required Usua user,
  required List<PlatformFile> files,
}) async {
  await Future.wait(files.map((file) async {
    final String fileName = file.name;

    final insertUserDocResponse = await firebaseRepository.insertUserDoc2(
      fileName: fileName,
      userId: user.id,
      fileBytes: file.bytes!.buffer.asUint8List(),
    );

    if (!insertUserDocResponse['success']) {
      return insertUserDocResponse;
    }

    user.addUserDoc(fileName);

    final updateUserDataResponse = await firebaseRepository.updateUserData2(
      data: {'docs': user.docs},
      userId: user.id,
    );

    if (!updateUserDataResponse['success']) {
      return updateUserDataResponse;
    }
  }));

  return {'success': true, 'message': 'Documento inserido com sucesso!'};
}
