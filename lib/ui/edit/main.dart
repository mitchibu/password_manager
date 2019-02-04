import 'package:flutter/material.dart';
import 'package:password_manager/statefulmodel.dart';

import '../../repository/model.dart';
import '../common/paged_adapter.dart';
import 'model.dart';

class EditPage extends StatefulWidget {
  final AccountView account;
  EditPage({
    AccountView account
  }) : this.account = account??AccountView();

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.account.category);
  }

  @override
  Widget build(BuildContext context) => StatefulModel<EditModel>.builder(
    creator: (context, previus) => EditModel(widget.account),
    builder: _build,
  );

  Widget _build(BuildContext context, EditModel model) => Scaffold(
    appBar: _buildAppBar(),
    body: LayoutBuilder(
      builder: (context, _) => _buildBody(context, model),
    ),
  );

  Widget _buildAppBar() => AppBar(
    title: Text('edit'),
  );

  Widget _buildBody(BuildContext context, EditModel model) => Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
                  child: _buildTitle(context, model),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: _buildCategory(context, model),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: _buildAccount(context, model),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: _buildPassword(context, model),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                  child: _buildComment(context, model),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          child: Text('test'),
          onPressed: () {
            if(_formKey.currentState.validate()) {
              _formKey.currentState.save();
              model.save();
            }
          },
        ),
      ],
    ),
  );

  Widget _buildText({
    @required String label,
    String initialValue,
    TextEditingController controller,
    bool obscureText = false,
    Widget suffixIcon,
    @required FormFieldValidator<String> validator,
    @required FormFieldSetter<String> onSaved,
  }) => TextFormField(
    obscureText: obscureText,
    initialValue: initialValue,
    controller: controller,
    validator: validator,
    onSaved: onSaved,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      suffixIcon: suffixIcon,
    ),
  );

  Widget _buildTitle(BuildContext context, EditModel model) => _buildText(
    label: 'Title',
    initialValue: model.account.title,
    validator: model.validateTitle,
    onSaved: model.saveTitle,
  );

  Widget _buildCategory(BuildContext context, EditModel model) => _buildText(
    label: 'Category',
    controller: categoryController,
    validator: model.validateCategory,
    onSaved: model.saveCategory,
    suffixIcon: IconButton(
      icon: Icon(Icons.category),
      onPressed: () => _chooseCategory(context, model),
    ),
  );

  void _chooseCategory(BuildContext context, EditModel model) => showModalBottomSheet(
    context: context,
    builder: (context) => GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: StreamBuilder<PagedAdapter<Category>>(
          initialData: model.adapter,
          stream: model.pagedStream,
          builder: (context, snapshot) => ListView.builder(
            itemCount: model.adapter.length,
            itemBuilder: (context, position) => _buildEntity(context, snapshot.data.getAt(position), model),
          ),
        ),
      ),
    ),
  );

  Widget _buildEntity(BuildContext context, Category category, EditModel model) => ListTile(
    title: ListTile(
      title: Text(category.name),
      onTap: () {
        categoryController.text = category.name;
        Navigator.of(context).pop();
      },
    ),
  );

  Widget _buildAccount(BuildContext context, EditModel model) => _buildText(
    label: 'Account',
    initialValue: model.account.name,
    validator: model.validateAccount,
    onSaved: model.saveAccount,
  );

  Widget _buildPassword(BuildContext context, EditModel model) => StreamBuilder<bool>(
    initialData: model.obscureText,
    stream: model.obscureTextStream,
    builder: (context, snapshot) => _buildText(
      label: 'Password',
      initialValue: model.account.password,
      obscureText: snapshot.data,
      validator: model.validatePassword,
      onSaved: model.savePassword,
      suffixIcon: IconButton(
        icon: Icon(snapshot.data ? Icons.visibility_off : Icons.visibility),
        onPressed: model.toggleObscureText,
      ),
    ),
  );

  Widget _buildComment(BuildContext context, EditModel model) => _buildText(
    label: 'Comment',
    initialValue: model.account.comment,
    validator: model.validateComment,
    onSaved: model.saveComment,
  );
}
