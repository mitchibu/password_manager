import 'dart:async';

import 'package:password_manager/statefulmodel.dart';

import '../../repository/model.dart';
import '../common/paged_adapter.dart';

class EditModel extends Model {
  final AccountView account;
  EditModel(this.account);

  final List<Category> entries = [];
  PagedAdapter<Category> adapter;
  StreamController<PagedAdapter<Category>> _pagedController = StreamController<PagedAdapter<Category>>();
  Stream<PagedAdapter<Category>> get pagedStream => _pagedController.stream;

  final _obscureTextController = StreamController<bool>();
  Stream get obscureTextStream => _obscureTextController.stream;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  void toggleObscureText() {
    _obscureTextController.sink.add(_obscureText = !_obscureText);
  }

  String validateTitle(String text) {
    print('title2');
    if(text.isEmpty) return 'Title must not be empty.';
    return null;
  }

  void saveTitle(String text) {
    print('title3');
    account.title = text;
  }

  String validateCategory(String text) {
    print('category2');
    return null;
  }

  void saveCategory(String text) {
    print('category3');
    account.category = text;
  }

  String validateAccount(String text) {
    print('account2');
    if(text.isEmpty) return 'Account must not be empty.';
    return null;
  }

  void saveAccount(String text) {
    print('account3');
    account.name = text;
  }

  String validatePassword(String text) {
    print('password2');
    return null;
  }

  void savePassword(String text) {
    print('password3');
    account.password = text;
  }

  String validateComment(String text) {
    print('comment2');
    return null;
  }

  void saveComment(String text) {
    print('comment3');
    account.comment = text;
  }

  void save() {
    print('title: ${account.title}');
    print('title: ${account.name}');
    print('password: ${account.password}');
    print('title: ${account.comment}');
  }

  @override
  void initState() {
    adapter = PagedAdapter<Category>(
      data: entries,
      pageSize: 20,
      distance: 5,
      onLoad: (int startPosition, int pageSize) {
        return Future.value(List.generate(pageSize, (i) {
          Category a = Category();
          a.id = startPosition + i + 1;
          a.name = 'category${a.id}';
          return a;
        }));
      },
      onUpdate: () => _pagedController.sink.add(adapter),
    );
  }

  @override
  void dispose() {
    _obscureTextController.close();
    _pagedController.close();
  }
}
