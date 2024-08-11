import 'package:flutter/material.dart';
import 'package:ukk_rpl_2024/controller/LoginController.dart';

class LoginView extends StatefulWidget {
  final LoginController controller;

  const LoginView({super.key, required this.controller});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _nimController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nimController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text("Login Page"),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Selamat Datang"),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _nimController,
                decoration: const InputDecoration(
                  label: Text("NIM"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String nim = _nimController.text;
                String password = _passwordController.text;
                widget.controller.login(context, nim, password);
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
