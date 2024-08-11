import 'package:mysql_client/mysql_client.dart';

class LoginModel {
  final MySQLConnection conn;

  LoginModel(this.conn);

  Future<bool> authentication(String nim, String password) async {
    var result = await conn.execute(
      "SELECT * FROM mahasiswa WHERE nim = :nim AND password = :password",
      {"nim": nim, "password": password},
    );

    return result.rows.isNotEmpty;
  }
}
