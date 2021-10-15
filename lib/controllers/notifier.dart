import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider/model/user.dart';

class UserNot extends ChangeNotifier {
  //This extending as Change Notifier tells the app that this class contains the variables which can be updated
  List<User> _userList = [];
  int _age = 0;
  int _height = 0;

  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);
  int get age => _age;
  int get height => _height;
 // A field is equivalent to a getter/setter pair. A final field is equivalent to a getter.
  //It is used to retrieve a particular class field and save it in a variable. All classes have a default getter method but it can be overridden explicitly.
  addUser(User user) {
    _userList.add(user);
    notifyListeners();
  }

  deleteUser(index) {
    _userList.removeWhere((_user) =>
        _user.name ==
        userList[index].name); //Removes the occurrence where the index matches
    notifyListeners();
  }

  incrementAge() {
    _age++;
    notifyListeners();
  }

  incrementHeight() {
    _height++;
    notifyListeners();
  }
}
