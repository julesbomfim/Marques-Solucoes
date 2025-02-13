import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthService2 extends GetxController {
  TextEditingController emailController = TextEditingController();

  Future resetPassword(BuildContext context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, '/homePage', (Route<dynamic> route) => false);
  }

  Future addUser(Usua user) async {
    final docUsua =
        FirebaseFirestore.instance.collection('Clientes2').doc();

    user.id = docUsua.id;

    await docUsua.set(user.toJson());
  }

  Future deleteUser(String id) async {
    final docUsua =
        FirebaseFirestore.instance.collection("Clientes2").doc(id);
    await docUsua.delete();
  }

  Future updateUser(Usua user) async {
    final docUsua =
        FirebaseFirestore.instance.collection("Clientes2").doc(user.id);
    await docUsua.update(user.toJson());
  }
}
