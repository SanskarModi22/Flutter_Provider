import 'package:flutter/material.dart';
import 'package:flutter_provider/controllers/notifier.dart';
import 'package:flutter_provider/model/user.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserNot userNotifier = Provider.of<UserNot>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserNot>(
                    builder: (_, notifier, __) => Text(
                      'Name: ${notifier.userList[index].name}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Consumer<UserNot>(
                    builder: (_, notifier, __) => Text(
                      'City: ${notifier.userList[index].city}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
//Consumer wraps a widget and notify the listener when there are changes in the wrapped widget
                ],
              ),
              Consumer<UserNot>(
                builder: (_, notifier, __) => IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => notifier.deleteUser(index),
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: userNotifier.userList.length,
    );
  }
}
