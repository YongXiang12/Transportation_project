import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transport/DB_Sqlite/UserEntity.dart';
import 'package:transport/DB_Sqlite/UserSelectEntity.dart';

class Controller{

 late Database audioContetDB ;
 late Database userSelectDB ;

// this is create AudioContent DB <3
Future<Database> createAudioContentDB() async {

  audioContetDB = await openDatabase(

      join(await getDatabasesPath() ,'audio_contet_db.db' ),

  onCreate : (db , version){

    return db.execute(
    'CREATE TABLE audio(id INTEGER PRIMARY KEY , audioPath TEXT , audioIndentity TEXT)',
    );
  },
  version : 1 ,
  );

  return audioContetDB ;
}


// this is create userSelect DB <3
Future<Database> createUserSelectDB() async{

  userSelectDB = await openDatabase(

      join(await getDatabasesPath() ,'user_select.db' ),

  onCreate : (db , version){

    return db.execute(
    'Create TABLE user(id INTEGER PRIMARY KEY , audioPath TEXT , audioIndentity TEXT)',
    );
  },
  version : 1 ,
  );
  return userSelectDB ;
}

 // init AudioDB DB
Future<Database> getAudioDBConnect() async{

    if(audioContetDB != null){
      return audioContetDB ;
    }
    return await createAudioContentDB();

}

 // init UserSelect DB

Future<Database> getUserSelectDBConnect() async{

  if(userSelectDB != null){
    return userSelectDB ;
  }
  return createUserSelectDB() ;
}

// get the audio Data

Future<List<UserEntity>> getAudios() async{

  final Database db = await getAudioDBConnect();

  final List<Map<String , dynamic>> Entitys = await db.query('audio');

  return List.generate(Entitys.length, (i) {
    return UserEntity(
        id: Entitys[i]['id'],
        audioPath: Entitys[i]['audioPath'],
        audioIndentity: Entitys[i]['audioIndentity'] ,
        fileName      : Entitys[i]['fileName'],
    );

  });

}


// get the User Select Data  ;

Future<List<UserSelectEntity>> getUserSelectEntity(){

  // TODO

}

// write the data into AudioData

Future<void> insertAudioData(UserEntity entity) async{

  final Database db = await getAudioDBConnect();
  await db.insert(
      'audio',
      entity.toMapping(),
      conflictAlgorithm: ConflictAlgorithm.replace,
  );

}
  //TODO
  // write the User Select Data into DataBase
  Future<void> insertUserSelectData(UserSelectEntity entity) async{

    final Database db = await getUserSelectDBConnect();
    await db.insert(
      'user',
      entity.toMapping(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }


  Future<void> deleteAudioData(String filename) async{
    final Database db = await getAudioDBConnect();
    await db.delete(
        'audio',
        where: "fileName = ? ",
        whereArgs: [filename],
    );
  }




}