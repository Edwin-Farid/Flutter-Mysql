import 'package:flutter/material.dart';
import 'package:ukk_rpl_2024/controller/MahasiswaController.dart';

class MahasiswaCreate extends StatefulWidget {
  final MahasiswaController controller;

  const MahasiswaCreate({super.key, required this.controller});

  @override
  State<MahasiswaCreate> createState() => _MahasiswaCreateState();
}

class _MahasiswaCreateState extends State<MahasiswaCreate> {
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _prodiController = TextEditingController();

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _prodiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text("Mahasiswa"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _nimController,
              decoration: const InputDecoration(labelText: "NIM"),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _prodiController,
              decoration: const InputDecoration(labelText: "Prodi"),
            ),
            ElevatedButton(
              onPressed: () {
                String nim = _nimController.text;
                String nama = _namaController.text;
                String username = _usernameController.text;
                String password = _passwordController.text;
                String prodi = _prodiController.text;
                widget.controller
                    .create(context, nim, nama, username, password, prodi);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
