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
    Navigator.pushNamed(
      context,
      '/mahasiswa-edit',
      arguments: {'nim': nim},
    );
  }

  void _deleteMahasiswa(String nim) async {
    await widget.controller.deleteMahasiswa(nim);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data berhasil di hapus"),
      ),
    );
    _refreshMahasiswaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text(
            "List Mahasiswa",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 94, 163, 220),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mahasiswa-create');
              },
              icon: const Icon(Icons.add),
              color: Colors.white,
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: _mahasiswaListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Data tidak ada"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final mahasiswa = snapshot.data![index];
                return Card(
                  color: const Color.fromARGB(255, 246, 246, 246),
                  elevation: 0,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NIM: ${mahasiswa['nim']}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Name: ${mahasiswa['name']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Prodi: ${mahasiswa['prodi']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _editMahasiswa(mahasiswa['nim']!);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 94, 163, 220)),
                              child: const Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _deleteMahasiswa(mahasiswa['nim']!);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 236, 82, 71)),
                              child: const Text(
                                "Hapus",
                                style: TextStyle(color: Colors.white),
                              ),
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
