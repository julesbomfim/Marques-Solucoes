part of 'firebase_repository.dart';

Future<Map<String, dynamic>> implUpdateUserData2({
  required Map<String, dynamic> data,
  required String userId,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection('Clientes2')
        .doc(userId)
        .update(data);

    return {
      'success': true,
      'message': 'Informações do usuário atualizadas com sucesso!',
    };
  } on FirebaseException catch (e) {
    return {
      'success': false,
      'message': e.message,
    };
  }
}


/*

  await FirebaseFirestore.instance
      .collection('Clientes')
      .doc(userId)
      .update({'docs': updatedDocs});

*/