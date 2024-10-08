import 'package:mysql_client/mysql_client.dart';

class MahasiswaModel {
  final MySQLConnection conn;

  MahasiswaModel(this.conn);

  Future<void> createMahasiswa(
      String nim, String nama, String password, String prodi) async {
    await conn.execute(
      "INSERT INTO mahasiswa (nim, nama, password, prodi) VALUE (:nim, :nama, :password, :prodi)",
      {"nim": nim, "nama": nama, "password": password, "prodi": prodi},
    );
  }

  Future<void> updateMahasiswa(
      String nim, String nama, String password, String prodi) async {
    await conn.execute(
      "UPDATE mahasiswa SET nama = :nama, password = :password, prodi = :prodi WHERE nim = :nim",
      {
        "nim": nim,
        "nama": nama,
        "password": password,
        "prodi": prodi,
      },
    );
  }

  Future<List<Map<String, String>>> getAllMahasiswa() async {
    var result = await conn.execute('SELECT * FROM mahasiswa');

    List<Map<String, String>> mahasiswaList = [];

    for (final row in result.rows) {
      mahasiswaList.add({
        'nim': row.colAt(0) ?? '',
        'name': row.colAt(1) ?? '',
        'prodi': row.colAt(2) ?? '',
      });
    }

    return mahasiswaList;
  }

  Future<Map<String, String>?> getMahasiswaByNim(String nim) async {
    var result = await conn.execute(
      "SELECT * FROM mahasiswa WHERE nim = :nim",
      {"nim": nim},
    );

    if (result.rows.isNotEmpty) {
      final row = result.rows.first;
      return {
        'nim': row.colAt(0) ?? '',
        'name': row.colAt(1) ?? '',
        'password': row.colAt(2) ?? '',
        'prodi': row.colAt(3) ?? '',
      };
    }

    return null;
  }

  Future<void> deleteMahasiswa(String nim) async {
    await conn.execute(
      'DELETE FROM mahasiswa WHERE nim = :nim',
      {"nim": nim},
    );
  }
}
