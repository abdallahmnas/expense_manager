import 'package:expense_management/components/custom_widgets.dart';
import 'package:expense_management/pages/dashboard.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Profile', style: TextStyle(color: primary_color)),
      //   backgroundColor: appBar_color,
      //   leading: GestureDetector(
      //       onTap: ()=>Navigator.pop(context),
      //       child: Icon(Icons.arrow_back,color: primary_color,)),
      // ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Expense',
                  style: TextStyle(
                      color: primary_color,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Manager',
                  style: TextStyle(
                      color: icon_color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyField(hint: 'Email'),
              SizedBox(
                height: 20,
              ),
              MyField(hint: 'Password', kType: 'password'),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 58,
                  decoration: BoxDecoration(
                      color: primary_color, //Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Dashboard())),
              )
              // InkBtn(
              //     text: 'Login',
              //     onClick: () => Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => Dashboard())))
            ],
          ),
        ),
      ),
    );
  }
}
