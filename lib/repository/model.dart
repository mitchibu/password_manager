import 'package:dao_generator_annotation/annotation.dart';

part 'model.g.dart';

@Entity()
class Account {
  int id;
  String title;
  int categoryId;
  String name;
  String password;
  String comment;
}

@Entity()
class Category {
  int id;
  String name;
}

@Entity()
class AccountView {
  int id;
  String title;
  String category;
  String name;
  String password;
  String comment;
}
