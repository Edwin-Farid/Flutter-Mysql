import 'package:flutter/material.dart';
import 'package:ukk_rpl_2024/model/MahasiswaModel.dart';

class MahasiswaController {
  final MahasiswaModel model;

  MahasiswaController(this.model);

  Future<void> create(BuildContext context, String nim, String nama,
      String username, String password, String prodi) async {
    try {
      await model.createMahasiswa(nim, nama, username, password, prodi);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data di simpan!"),
        ),
      );
    } catch (e) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> edit(BuildContext context, String nim, String name,
      String username, String password, String prodi) async {
    try {
      await model.updateMahasiswa(nim, name, username, password, prodi);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data Berhasil di perbarui"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e}"),
        ),
      );
    }
  }

  Future<Map<String, String>?> getMahasiswa(String nim) async {
    return await model.getMahasiswaByNim(nim);
  }

  Future<List<Map<String, String>>> fetchAllMahasiswa() async {
    return await model.getAllMahasiswa();
  }

  Future<void> deleteMahasiswa(String nim) async {
    await model.deleteMahasiswa(nim);
  }
}
