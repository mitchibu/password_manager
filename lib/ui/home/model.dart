import 'dart:async';

import 'package:password_manager/statefulmodel.dart';

import '../../repository/model.dart';
import '../common/paged_adapter.dart';

class HomeModel extends Model {
  final List<AccountView> entries = [];

  PagedAdapter<AccountView> adapter;
  StreamController<PagedAdapter<AccountView>> _pagedController = StreamController<PagedAdapter<AccountView>>();
  Stream<PagedAdapter<AccountView>> get pagedStream => _pagedController.stream;

  void update() => _pagedController.sink.add(adapter);

  bool _isVisibility = true;
  bool get isVisibility => _isVisibility;
  StreamController<bool> _isVisibilityController = StreamController<bool>();
  Stream<bool> get isVisibilityStream => _isVisibilityController.stream;

  void setIsVisibility(bool isVisibility) => _isVisibilityController.sink.add(_isVisibility = isVisibility);

  @override
  void initState() {
    adapter = PagedAdapter<AccountView>(
      data: entries,
      pageSize: 20,
      distance: 5,
      onLoad: (int startPosition, int pageSize) {
        return Future.value(List.generate(pageSize, (i) {
          AccountView a = AccountView();
          a.id = startPosition + i + 1;
          a.title = 'title${a.id}';
          a.category = 'category${a.id}';
          a.name = 'name${a.id}';
          a.password = 'password${a.id}';
          a.comment = 'comment${a.id}';
          return a;
        }));
      },
      onUpdate: update,
    );
  }

  @override
  void dispose() {
    _isVisibilityController.close();
    _pagedController.close();
  }
}
