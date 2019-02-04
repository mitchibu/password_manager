import 'package:flutter/widgets.dart';

typedef Future<List<T>> PageFuture<T>(int startPosition, int pageSize);

class PagedAdapter<T> {
  final int pageSize;
  final int distance;
  final PageFuture<T> onLoad;
  final VoidCallback onUpdate;
  final List<T> _entries;

  bool _hasNext = true;
  bool _isLoading = false;

  int get length => _entries.length;

  PagedAdapter({
    List<T> data,
    @required this.pageSize,
    @required this.onLoad,
    @required this.onUpdate,
    this.distance = 5
  }) : _entries = data ?? [] {
    _load(_entries.length, pageSize);
  }

  T getAt(int index) {
    int n = _entries.length;
    if(!_isLoading && _hasNext && index == n - distance) {
      _load(_entries.length, pageSize);
    }
    return _entries.elementAt(index);
  }

  void insert(int index, T entry) {
    _entries.insert(index, entry);
  }

  void removeAt(int index) {
    _entries.removeAt(index);
  }

  void _load(int startPosition, int pageSize) async {
    _isLoading = true;
    List<T> result = await onLoad(startPosition, pageSize);
    _hasNext = result.isNotEmpty;
    if(_hasNext) {
      _entries.addAll(result);
      onUpdate();
    }
    _isLoading = false;
  }
}