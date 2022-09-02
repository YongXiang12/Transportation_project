import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transport/DB_Sqlite/UserEntity.dart';
import 'package:transport/DB_Sqlite/UserSelectEntity.dart';

class Controller {
  static late Database audioContetDB;
  static late Database userSelectDB;

// this is create AudioContent DB <3
  static Future<Database> createAudioContentDB() async {
    String name = await getDatabasesPath();
    print("音檔位置:");
    print(name);
    audioContetDB = await openDatabase(
      join(await getDatabasesPath(), 'audio_contet_db2.db'),
      onCreate: (db, version) {
        print("音檔位置:");
        print(name);
        return db.execute(
          "CREATE TABLE audio(id INTEGER , audioPath TEXT , audioIndentity TEXT , fileName TEXT)",
        );
      },
      version: 1,
    );
    print("音檔位置:");
    print(name);
    return audioContetDB;
  }

// this is create userSelect DB <3
  static Future<Database> createUserSelectDB() async {
    userSelectDB = await openDatabase(
      join(await getDatabasesPath(), 'user_select2.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(id INTEGER , default_select TEXT , select_indentity TEXT , audioPath TEXT)",
        );
      },
      version: 1,
    );
    return userSelectDB;
  }

  // init AudioDB DB
  static Future<Database> getAudioDBConnect() async {
    if (audioContetDB != null) {
      return audioContetDB;
    }
    return await createAudioContentDB();
  }

  // init UserSelect DB
  static Future<Database> getUserSelectDBConnect() async {
    if (userSelectDB != null) {
      return userSelectDB;
    }
    return await createUserSelectDB();
  }

// get the audio Data
  static Future<List<UserEntity>> getAudiosList() async {
    final Database db = await getAudioDBConnect();

    final List<Map<String, dynamic>> Entitys = await db.query('audio');

    return List.generate(Entitys.length, (i) {
      return UserEntity(
        id: Entitys[i]['id'],
        audioPath: Entitys[i]['audioPath'],
        audioIndentity: Entitys[i]['audioIndentity'],
        fileName: Entitys[i]['fileName'],
      );
    });
  }

// get the User Select Data  ;

  static Future<List<UserSelectEntity>> getUserSelectList() async {
    final Database db = await getUserSelectDBConnect();

    final List<Map<String, dynamic>> Entitys = await db.query('user');

    return List.generate(Entitys.length, (i) {
      return UserSelectEntity(
        id: Entitys[i]['id'],
        default_select: Entitys[i]['default_select'],
        select_indentity: Entitys[i]['select_indentity'],
        audioPath: Entitys[i]['audioPath'],
      );
    });
  }

// write the data into AudioData
  static Future<void> insertAudioData(UserEntity entity) async {
    final Database db = await getAudioDBConnect();
    await db.insert(
      'audio',
      entity.toMapping(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // write the User Select Data into DataBase
  static Future<void> insertUserSelectData(UserSelectEntity entity) async {
    final Database db = await getUserSelectDBConnect();
    await db.insert(
      'user',
      entity.toMapping(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAudioData(int id) async {
    final Database db = await getAudioDBConnect();
    await db.delete(
      'audio',
      where: "id = ? ",
      whereArgs: [id],
    );
  }

  static Future<void> deleteselectData(int id) async {
    final Database db = await getUserSelectDBConnect();
    await db.delete(
      'user',
      where: "id = ? ",
      whereArgs: [id],
    );
  }
}
