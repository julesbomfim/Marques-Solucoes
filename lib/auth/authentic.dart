import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthService extends GetxController {
  TextEditingController emailController = TextEditingController();

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

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
        FirebaseFirestore.instance.collection('Clientes').doc();

    user.id = docUsua.id;

    await docUsua.set(user.toJson());
  }

  Future deleteUser(String id) async {
    final docUsua =
        FirebaseFirestore.instance.collection("Clientes").doc(id);
    await docUsua.delete();
  }

  Future updateUser(Usua user) async {
    final docUsua =
        FirebaseFirestore.instance.collection("Clientes").doc(user.id);
    await docUsua.update(user.toJson());
  }
}
