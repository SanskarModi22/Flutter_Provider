import 'package:flutter/material.dart';
import 'package:flutter_provider/api/cheetah_api.dart';
import 'package:flutter_provider/controllers/notifier.dart';
import 'package:flutter_provider/model/user.dart';
import 'package:flutter_provider/screens/user_list_screen.dart';
import 'package:flutter_provider/widget/cheetah_button.dart';
import 'package:flutter_provider/widget/cheetah_input.dart';
import 'package:flutter_provider/widget/user_list.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String _name;
  String _city;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserNot userNotifier = Provider.of<UserNot>(
        context); //This is used for creating the instance of UserNot
    //watch() function disadvantage is that rebuilds the app whenver the listener is notified
    //Consumer does not rebuild the widget tree again and again
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        actions: [
          Center(
            //This Selector is equally powerful as Consumer or watch() function
            //Unlike watch() function it does not rebuild the widget tree again and again
            //It is highly selective and filter updates by selecting limited amount of values
            child: Selector<UserNot, int>(
              selector: (_, notifier) => notifier.age,
              builder: (_, age, __) => Text(
                age.toString(),
              ),
            ),
          )
        ],
        leading: Text(
          context.watch<int>().toString(),
        ),
        //Using Stream Provier here
        //We could have also used Consumer here
        title: Text(
          context.watch<String>(),
          //We can also use watch()
          //we are getting data from the future provider
          //If we had 2 future provider return String type then this would have called
          //2 times at intervals
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureProvider(
                create: (_) => getCurrentTime(),
                initialData: "Loading Data...",
                child: Consumer<String>(
                  //If we are using watch() it is getting confused but with Consumer giving expected answer
                  builder: (_, notif, __) => Text(
                    notif,
                  ),
                ),
              ), //Here we are localizing the Future provider to a single class.
              //Earlier we had used it in MultiProvider
              CheetahInput(
                labelText: 'Name',
                onSaved: (String value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16),
              CheetahInput(
                labelText: 'City',
                onSaved: (String value) {
                  _city = value;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheetahButton(
                    text: 'Add',
                    onPressed: () {
                      if (!_formKey.currentState.validate()) return;

                      _formKey.currentState.save();

                      context.read<UserNot>().addUser(User(_name, _city));
                      //Whenever we use any function from a Notifier class we use read function
                      //and not watch() function+
                    },
                  ),
                  SizedBox(width: 8),
                  CheetahButton(
                    text: 'List',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserListScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 8),
                  CheetahButton(
                    text: 'Age',
                    onPressed: () {
                      context.read<UserNot>().incrementAge();
                    },
                  ),
                  SizedBox(width: 8),
                  CheetahButton(
                      text: 'Height',
                      onPressed: () {
                        context.read<UserNot>().incrementHeight();
                      }),
                ],
              ),
              SizedBox(height: 20),
              UserList(),
            ],
          ),
        ),
      ),
    );
  }
}
