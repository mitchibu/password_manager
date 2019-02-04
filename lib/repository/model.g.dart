// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// EntityGenerator
// **************************************************************************

String get $AccountSql => 'create table Account('
    'id integer'
    ',title text'
    ',categoryId integer'
    ',name text'
    ',password text'
    ',comment text'
    ')';
Account getAccountFromMap(Map<String, dynamic> map, {prefix = ''}) {
  var entity = Account();
  entity.id = map['${prefix}id'];
  entity.title = map['${prefix}title'];
  entity.categoryId = map['${prefix}categoryId'];
  entity.name = map['${prefix}name'];
  entity.password = map['${prefix}password'];
  entity.comment = map['${prefix}comment'];
  return entity;
}

List<Account> getAccountFromList(List<Map<String, dynamic>> maps,
    {prefix = ''}) {
  List<Account> entities = [];
  maps.forEach((map) {
    entities.add(getAccountFromMap(map, prefix: prefix));
  });
  return entities;
}

Map<String, dynamic> getAccountToMap(Account entity) {
  return {
    'id': entity.id,
    'title': entity.title,
    'categoryId': entity.categoryId,
    'name': entity.name,
    'password': entity.password,
    'comment': entity.comment,
  };
}

String get $CategorySql => 'create table Category('
    'id integer'
    ',name text'
    ')';
Category getCategoryFromMap(Map<String, dynamic> map, {prefix = ''}) {
  var entity = Category();
  entity.id = map['${prefix}id'];
  entity.name = map['${prefix}name'];
  return entity;
}

List<Category> getCategoryFromList(List<Map<String, dynamic>> maps,
    {prefix = ''}) {
  List<Category> entities = [];
  maps.forEach((map) {
    entities.add(getCategoryFromMap(map, prefix: prefix));
  });
  return entities;
}

Map<String, dynamic> getCategoryToMap(Category entity) {
  return {
    'id': entity.id,
    'name': entity.name,
  };
}

String get $AccountViewSql => 'create table AccountView('
    'id integer'
    ',title text'
    ',category text'
    ',name text'
    ',password text'
    ',comment text'
    ')';
AccountView getAccountViewFromMap(Map<String, dynamic> map, {prefix = ''}) {
  var entity = AccountView();
  entity.id = map['${prefix}id'];
  entity.title = map['${prefix}title'];
  entity.category = map['${prefix}category'];
  entity.name = map['${prefix}name'];
  entity.password = map['${prefix}password'];
  entity.comment = map['${prefix}comment'];
  return entity;
}

List<AccountView> getAccountViewFromList(List<Map<String, dynamic>> maps,
    {prefix = ''}) {
  List<AccountView> entities = [];
  maps.forEach((map) {
    entities.add(getAccountViewFromMap(map, prefix: prefix));
  });
  return entities;
}

Map<String, dynamic> getAccountViewToMap(AccountView entity) {
  return {
    'id': entity.id,
    'title': entity.title,
    'category': entity.category,
    'name': entity.name,
    'password': entity.password,
    'comment': entity.comment,
  };
}
