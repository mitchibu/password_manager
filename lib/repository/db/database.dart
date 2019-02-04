import 'package:dao_generator_annotation/annotation.dart';
import 'package:dao_generator_sqlite/sqlite.dart';

import '../model.dart';

part 'database.g.dart';

class DatabaseFactory<T> {
  static dynamic _db;
  static T getDatabase<T>() {
    if(_db == null) {
      _db = openMyDatabase();
    }
    return _db;
  }
}

@Database(entities: [Account, Category], version: 1)
abstract class MyDatabase {
  AccountViewDao accountDao();
}

@Dao()
abstract class AccountViewDao {
  @Query('select * from AccoutView')
  Future<List<AccountView>> getAll();
}

@Dao()
abstract class CategoryDao {
  @Query('select * from Category')
  Future<List<Category>> getAll();
}
