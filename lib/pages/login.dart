import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/repository/api_repository.dart';
import '../injection.dart';
import '../state/user_provider.dart';
import '../utils/AppUtil.dart';
import 'elements/dialogs.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: mobileController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "07XX XXX XXX",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            maxLength: 4,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isLoggingIn
              ? RaisedButton(
                  onPressed: null,
                  disabledColor: Colors.grey,
                  elevation: 10,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  elevation: 10,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () => _loginUser(),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/VerifyPage"),
            child: Text(
              'VERIFY ACCOUNT',
              style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _loginUser() {
    if (mobileController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var params = {
        "phoneNumber": AppUtil.formatMobileNumber(mobileController.text),
        "password": passwordController.text
      };

      setState(() {
        isLoggingIn = !isLoggingIn;
      });

      getIt.get<ApiRepository>().loginUser(params).then((value) {
        Provider.of<UserProvider>(context, listen: false).defaultUser = {
          "fullname": value.fullName,
          "aginId": value.youthAGINID,
          "mobile": AppUtil.formatMobileNumber(value.phoneNumber)
        };
        Navigator.pushNamed(context, "/HomePage");
      }).catchError((err) {
        Fimber.e(err.toString());
        if (err is DioError) {
          Dialogs.messageDialog(context, true, err.message);
        }

        setState(() {
          isLoggingIn = !isLoggingIn;
        });
      });
    }
  }
}
