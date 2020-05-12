import 'package:flutter/material.dart';
import 'package:whatsapp/global/main_global.dart';
import 'package:whatsapp/helper/widget_helper.dart';
import 'package:whatsapp/services/model/user_model.dart';
import 'package:whatsapp/services/user_service.dart';
import '../tab_base.dart';

class Contact extends TabBase {
  @override
  String Title = "Contatos";

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  UserService _userSerice;

  _ContactState() {
    _userSerice = UserService();
  }

  Widget _list(AsyncSnapshot<List<UserModel>> snapshot) {
    List<UserModel> filterUser =
        snapshot.data.where((u) => u.uid != MainGlobal.userModel.uid).toList();
    return ListView.separated(
        itemBuilder: (context, index) => _itemList(filterUser[index]),
        separatorBuilder: (context, index) =>
            Divider(height: 2, color: Colors.grey),
        itemCount: filterUser.length);
  }

  Widget _itemList(UserModel user) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/chat", arguments: user),
        child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.grey,
                backgroundImage: (user.urlImage == null)
                    ? AssetImage('assets/images/contacts/no-img.png')
                    : NetworkImage(user.urlImage)),
            title: Text(user.name,
                style: TextStyle(fontWeight: FontWeight.bold))));
  }

  Widget _noItems() => Container(
      height: 50,
      child: Center(
        child: Text(
          "Você não tem nenhum contato.",
          textAlign: TextAlign.center,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<UserModel>>(
            future: _userSerice.GetAll(),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return WidgetHelper.loading(Colors.green);
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  return (snapshot.hasData) ? _list(snapshot) : _noItems();
                  break;
              }
            }));
  }
}
