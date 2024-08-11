# Flutter Apps using MySQL Database

This simple project that can be refrence if you have local project using Flutter & MySQL.

This apps using 2 dependency :
- mysql_client
- http

# Getting Started
Think your must know !

This Apps using MVC design pattern.

## Connection to MySQL

final conn = await MySQLConnection.createConnection(
      host: "10.0.2.2",
      port: 3306,
      userName: 'root',
      password: '',
      databaseName: "db_edwinfarid_ukk_rpl_2024",
      secure: false);

  await conn.connect();