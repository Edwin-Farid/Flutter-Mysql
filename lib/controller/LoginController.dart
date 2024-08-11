import 'package:flutter/material.dart';
import 'package:ukk_rpl_2024/model/LoginModel.dart';

class LoginController {
  final LoginModel model;

  LoginController(this.model);

  Future<void> login(BuildContext context, String nim, String password) async {
    bool isAuthenticated = await model.authentication(nim, password);

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/mahasiswa');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Gagal!"),
        ),
      );
    }
  }
}
