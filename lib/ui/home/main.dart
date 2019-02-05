import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:password_manager/statefulmodel.dart';

import '../../model.dart';
import '../../repository/model.dart';
import '../../test.dart';
import '../common/paged_adapter.dart';
import '../edit/main.dart';
import 'model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StatefulModel<HomeModel>.builder(
    creator: (context, previus) => HomeModel(),
    builder: _build,
  );

  Widget _build(BuildContext context, HomeModel model) => Scaffold(
    appBar: _buildAppBar(),
    body: _buildBody(context, model),
    drawer: _buildDrawer(context),
    floatingActionButton: _buildFloatingActionButton(context, model),
  );

  Widget _buildAppBar() => AppBar(
    title: Text('home'),
  );

  Widget _buildDrawer(BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('item1'),
          onTap: () {
//            StatefulModel.of<AppModel>(context).setThemeData(ThemeData.light());
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: Text('item2'),
          onTap: () {
//            StatefulModel.of<AppModel>(context).setThemeData(ThemeData.dark());
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );

  Widget _buildFloatingActionButton(BuildContext context, HomeModel model) => StreamBuilder<bool>(
    initialData: model.isVisibility,
    stream: model.isVisibilityStream,
    builder: (context, snapshot) => AnimatedOpacity(
      opacity: snapshot.data ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: FloatingActionButton(
        onPressed: snapshot.data ? () => _editAccount(context) : null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    ),
  );

  Widget _buildBody(BuildContext context, HomeModel model) => NotificationListener(
    onNotification: (notification) {
      if(notification is UserScrollNotification) {
        model.setIsVisibility(notification.direction == ScrollDirection.idle);
      }
    },
    child: StreamBuilder<PagedAdapter<AccountView>>(
      initialData: model.adapter,
      stream: model.pagedStream,
      builder: (context, snapshot) => ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, position) => _buildEntry(context, position, model),
      ),
    ),
  );

  Widget _buildEntry(BuildContext context, int position, HomeModel model) {
    int now = DateTime.now().millisecondsSinceEpoch;
    AccountView account = model.adapter.getAt(position);
    ThemeData theme = Theme.of(context);
    return Dismissible(
      key: Key('item${account.id} $now'),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white,),
      ),
      onDismissed: (direction) async {
        bool isRemoved = true;
        Scaffold.of(context).hideCurrentSnackBar();
        await Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text('\'${account.title}\' has deleted.'),
          duration: const Duration(milliseconds: 8000),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              isRemoved = false;
            },
          ),
        )).closed;

        if(isRemoved) {
          model.adapter.removeAt(position);
        }
        model.update();
      },
      child: ListTile(
        title: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: theme.accentColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  account.category,
                  style: theme.accentTextTheme.subtitle,
                ),
              ),
            ),
            Container(margin: EdgeInsets.only(left: 8.0), child: Text(account.title),),
          ]
        ),
        subtitle: Text(account.name),
        onTap: () async {
          if(StatefulModel.of<AppModel>(context).isMushroom) {
            await Clipboard.setData(ClipboardData(text: account.name));
            //Navigator.of(context).pop({'replace_key': account.password});
            finish(account.password);
          } else {
            _editAccount(context, account: account);
          }
        }
      ),
    );
  }

  void _editAccount(BuildContext context, {AccountView account}) {
    Scaffold.of(context).hideCurrentSnackBar();
    Navigator.of(context).push(PageTransition(type: PageTransitionType.rightToLeftWithFade, child: EditPage(account: account)));
  }
}
