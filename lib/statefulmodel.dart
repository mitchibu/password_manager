import 'package:flutter/widgets.dart';

class Model {
  void initState() {}
  void dispose() {}
}

typedef ModelCreator<T extends Model> = T Function(BuildContext context, T previus);
typedef ModelBuilder<T extends Model> = Widget Function(BuildContext context, T model);

class StatefulModel<T extends Model> extends StatefulWidget {
  static T of<T extends Model>(BuildContext context) {
    Type _typeof<T>() => T;
    InheritedElement e = context.ancestorInheritedElementForWidgetOfExactType(_typeof<_Inherited<T>>());
    return (e.widget as _Inherited<T>).model;
  }

  final ModelCreator<T> creator;
  final Widget child;
  final ModelBuilder<T> builder;

  const StatefulModel({
    Key key,
    @required this.creator,
    this.child,
    this.builder,
  }) : assert(creator != null),
       assert(child != null || builder != null),
       super(key: key);

  const StatefulModel.builder({
    Key key,
    @required ModelCreator<T> creator,
    @required ModelBuilder<T> builder,
  }) : this(
         key: key,
         creator: creator,
         builder: builder,
       );

  @override
  _StatefulModelState<T> createState() => _StatefulModelState<T>();
}

class _StatefulModelState<T extends Model> extends State<StatefulModel<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    _createModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StatefulModel<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _createModel();
  }

  @override
  Widget build(BuildContext context) => _Inherited<T>(
    model: _model,
    child: widget.child,
    context: context,
    builder: widget.builder,
  );

  void _createModel() {
    _model = widget.creator(context, _model);
    _model.initState();
  }
}

class _Inherited<T extends Model> extends InheritedWidget {
  final T model;

  _Inherited({
    Key key,
    @required this.model,
    @required Widget child,
    BuildContext context,
    ModelBuilder<T> builder,
  }) : super(key: key, child: child??builder(context, model));

  @override
  bool updateShouldNotify(_Inherited<T> oldWidget) => model != oldWidget.model;
}
