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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text(
            "Login Page",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 94, 163, 220),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Selamat Datang"),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: "NIM",
                  labelStyle: TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 94, 163, 220),
                    ),
                  ),
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
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 94, 163, 220),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                String nim = _nimController.text;
                String password = _passwordController.text;
                widget.controller.login(context, nim, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 94, 163, 220),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
