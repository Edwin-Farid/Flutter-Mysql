import 'package:flutter/material.dart';
import 'package:ukk_rpl_2024/controller/MahasiswaController.dart';

class MahasiswaEdit extends StatefulWidget {
  final MahasiswaController controller;
  final String nim;

  const MahasiswaEdit({super.key, required this.controller, required this.nim});

  @override
  State<MahasiswaEdit> createState() => _MahasiswaEditState();
}

class _MahasiswaEditState extends State<MahasiswaEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _prodiController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _prodiController = TextEditingController();
    _loadMahasiswaData();
  }

  void _loadMahasiswaData() async {
    final mahasiswa = await widget.controller.getMahasiswa(widget.nim);
    if (mahasiswa != null) {
      _nameController = TextEditingController(text: mahasiswa['name']);
      _passwordController = TextEditingController(text: mahasiswa['password']);
      _prodiController = TextEditingController(text: mahasiswa['prodi']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data Mahasiswa Tidak terbaca!"),
        ),
      );
      Navigator.pop(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
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
          title: const Text("Edit Mahasiswa"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: TextEditingController(text: widget.nim),
              keyboardType: TextInputType.text,
              readOnly: true,
              decoration: const InputDecoration(labelText: "NIM"),
            ),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            TextFormField(
              controller: _prodiController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Prodi"),
            ),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String password = _passwordController.text;
                String prodi = _prodiController.text;
                widget.controller
                    .edit(context, widget.nim, name, password, prodi);
              },
              child: const Text("Simapn Pembaruan"),
            ),
          ],
        ),
      ),
    );
  }
}
