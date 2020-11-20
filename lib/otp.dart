import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:AgriView/utils/constants.dart';


int statusCode;
Future<Message> verifyAccount (
    String phoneNumber,
    String verifyCode) async {

  final http.Response response = await http.post(
    Uri.parse('${serverURL}aggregator/account/verify'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-AGIN-API-Key-Token': APIKEY,
    },
    body: jsonEncode(<String, String>{
      'verifyCode': verifyCode,
      'phoneNumber': phoneNumber,
    }),
  );

  statusCode = response.statusCode;
  if (response.statusCode == 200) {
    return Message.fromJson(json.decode(response.body));
  } else {
    return Message.fromJson(json.decode(response.body));
  }
}

class Message {
  final String message;
  final String responsecode;

  Message({this.message, this.responsecode});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      responsecode: json['responsecode'],
    );
  }
}


class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _phoneNumber = "";
  Map data = {};
  Future<Message> _futureMessage;


  @override
  void initState() {
    super.initState();
    //_getSignatureCode();

  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature"); //tTM/NO6iyM5
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });
    });

      //go online to verify
      _futureMessage = verifyAccount(
          _phoneNumber,
          _otpCode).then((value){

          setState(() {
            _isLoadingButton = false;
            _enableButton = true;
          });

        Message message = value;
        if(statusCode == 200){

            Navigator.of(context).popAndPushNamed('/');

        }else{
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(message.message)));
        }
        return;
      });

  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    _phoneNumber = data['phoneNumber'].toString();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Verify $_phoneNumber'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: Text(
                "Waiting to automatically detect an SMS sent to $_phoneNumber",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              TextFieldPin(
                filled: true,
                filledColor: Colors.grey,
                codeLength: _otpCodeLength,
                boxSize: 46,
                filledAfterTextChange: false,
                textStyle: TextStyle(fontSize: 16),
                borderStyle: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(34)),
                onOtpCallback: (code, isAutofill) =>
                    _onOtpCallBack(code, isAutofill),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                width: double.maxFinite,
                child: MaterialButton(
                  onPressed: _enableButton ? _onSubmitOtp : null,
                  child: _setUpButtonChild(),
                  color: Theme.of(context).primaryColorDark,
                  disabledColor: Theme.of(context).primaryColorLight,
                  highlightElevation: 0.0,
                  elevation: 0.0,
                  height: 50.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      );
    }
  }

}
