// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DatabaseGenerator
// **************************************************************************

//Type (Account)
//Account
//$AccountSql
//Type (Category)
//Category
//$CategorySql
MyDatabase openMyDatabase({String path = ':memory:'}) => _$MyDatabase(path);

class _$MyDatabase extends MyDatabase {
  final DatabaseHelper _helper;
  _$MyDatabase(String path)
      : _helper = DatabaseHelper(path, 1, (db, version) async {
          await db.execute($AccountSql);
          await db.execute($CategorySql);
        });
  @override
  AccountViewDao accountDao() {
    return _$AccountViewDao(_helper);
  }
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

class _$AccountViewDao extends AccountViewDao {
  final DatabaseHelper _helper;
  _$AccountViewDao(this._helper);
  @override
  Future<List<AccountView>> getAll() async {
    var executor = await _helper.getExecutor();
    var result = await executor.query('select * from AccoutView');
    return getAccountViewFromList(result);
  }
}

class _$CategoryDao extends CategoryDao {
  final DatabaseHelper _helper;
  _$CategoryDao(this._helper);
  @override
  Future<List<Category>> getAll() async {
    var executor = await _helper.getExecutor();
    var result = await executor.query('select * from Category');
    return getCategoryFromList(result);
  }
}
