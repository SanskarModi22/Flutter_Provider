import 'package:flutter/material.dart';
import 'package:flutter_provider/controllers/notifier.dart';
import 'package:flutter_provider/model/user.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                   Text(
                      'Name: ${context.watch<UserNot>().userList[index].name}',
                      style: TextStyle(fontSize: 18),
                    ),
//Here we have replaced Consumer with watch() function
                  Text(
                    'Name: ${context.watch<UserNot>().userList[index].city}',
                    style: TextStyle(fontSize: 18),
                  ),
//Consumer wraps a widget and notify the listener when there are changes in the wrapped widget
                ],
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => context.read<UserNot>().deleteUser(index),
                ),

            ],
          ),
        ),
      ),
      itemCount: context.watch<UserNot>().userList.length,
      //Here the above line means that
      // we are watching the changes in the UserNot class and will
      // update the length of userList accordingly
    );
  }
}
