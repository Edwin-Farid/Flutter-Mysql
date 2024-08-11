import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:ukk_rpl_2024/controller/LoginController.dart';
import 'package:ukk_rpl_2024/controller/MahasiswaController.dart';
import 'package:ukk_rpl_2024/model/LoginModel.dart';
import 'package:ukk_rpl_2024/model/MahasiswaModel.dart';
import 'package:ukk_rpl_2024/view/home.dart';
import 'package:ukk_rpl_2024/view/login.dart';
import 'package:ukk_rpl_2024/view/mahasiswa/create.dart';
import 'package:ukk_rpl_2024/view/mahasiswa/edit.dart';
import 'package:ukk_rpl_2024/view/mahasiswa/index.dart';

void main() async {
  final conn = await MySQLConnection.createConnection(
      host: "10.0.2.2",
      port: 3306,
      userName: 'root',
      password: 'semogaberkah',
      databaseName: "db_edwinfarid_ukk_rpl_2024",
      secure: false);

  await conn.connect();

  final model = LoginModel(conn);
  final controller = LoginController(model);

  final modelMahasiswa = MahasiswaModel(conn);
  final controllerMahasiswa = MahasiswaController(modelMahasiswa);

  MyApp app = MyApp(
    controller: controller,
    controllerMahasiswa: controllerMahasiswa,
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  final LoginController controller;
  final MahasiswaController controllerMahasiswa;

  const MyApp(
      {super.key, required this.controller, required this.controllerMahasiswa});

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => LoginView(controller: controller),
        '/home': (context) => const HomePage(),
        '/mahasiswa': (context) =>
            MahasiswaIndex(controller: controllerMahasiswa),
        '/mahasiswa-create': (context) =>
            MahasiswaCreate(controller: controllerMahasiswa),
        '/mahasiswa-edit': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return MahasiswaEdit(
            controller: controllerMahasiswa,
            nim: args['nim'],
          );
        }
      },
      initialRoute: '/',
    );
    return materialApp;
  }
}
