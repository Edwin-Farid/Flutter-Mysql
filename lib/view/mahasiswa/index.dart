import 'package:flutter/material.dart';
import 'package:ukk_rpl_2024/controller/MahasiswaController.dart';

class MahasiswaIndex extends StatefulWidget {
  final MahasiswaController controller;

  const MahasiswaIndex({super.key, required this.controller});

  @override
  State<MahasiswaIndex> createState() => _MahasiswaIndexState();
}

class _MahasiswaIndexState extends State<MahasiswaIndex> {
  late Future<List<Map<String, String>>> _mahasiswaListFuture;

  @override
  void initState() {
    super.initState();
    _mahasiswaListFuture = widget.controller.fetchAllMahasiswa();
  }

  void _refreshMahasiswaList() {
    setState(() {
      _mahasiswaListFuture = widget.controller.fetchAllMahasiswa();
    });
  }

  void _editMahasiswa(String nim) {
    Navigator.pushReplacementNamed(
      context,
      '/mahasiswa-edit',
      arguments: {'nim': nim},
    );
  }

  void _deleteMahasiswa(String nim) async {
    await widget.controller.deleteMahasiswa(nim);
    _refreshMahasiswaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text("Mahasiswa"),
        ),
      ),
      body: FutureBuilder(
        future: _mahasiswaListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Data tidak ada"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final mahasiswa = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "NIM: ${mahasiswa['nim']}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Name: ${mahasiswa['name']}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Prodi: ${mahasiswa['prodi']}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _editMahasiswa(mahasiswa['nim']!);
                              },
                              child: Text("Edit"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _deleteMahasiswa(mahasiswa['nim']!);
                              },
                              child: Text("Hapus"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
