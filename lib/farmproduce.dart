import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class FarmProduce extends StatefulWidget {
  @override
  _FarmProduceState createState() => _FarmProduceState();
}

class _FarmProduceState extends State<FarmProduce> {

  String _farmerAginID;
  String _farmProduceID;
  String _farmID;

  String dropdownValueProduce = 'Select Produce';
  String dropdownValueFarm = "Select Farm";
  //input widget
  Widget _input(Icon icon, String hint, TextEditingController controller,
      bool obsecure) {
    int maxlength = 200;
    int minLine = 1;
    TextInputType textInputType = TextInputType.text;
    if(hint.compareTo("CURRENT LAND USE") == 0){
      maxlength = 300;
      minLine = 4;
    }else if(hint.compareTo("ACREAGE MAPPED") == 0 ||
        hint.compareTo("ACREAGE APPROVED") == 0){
      maxlength = 10;
      textInputType = TextInputType.number;
    }

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        keyboardType: textInputType,
        maxLength: maxlength,
        controller: controller,
        obscureText: obsecure,
        minLines: minLine,
        expands: true,
        style: TextStyle(
            fontSize: 15,
            letterSpacing: 1.0
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            hintText: hint,
            labelText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Theme.of(context).primaryColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }

  //button widget
  Widget _button(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 15),
      ),
      onPressed: () {
        function();
      },
    );
  }

  void _registerFarmProduce() {

  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER PRODUCE',
            style : TextStyle(
              fontSize: 15.0,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).canvasColor),
        child: ClipRRect(
          /* borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0)),*/
          child: Container(
            child: ListView(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: dropdownValueProduce,
                          icon: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,8,0),
                            child: Icon(
                              Icons.arrow_drop_down_circle,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          isExpanded: true,
                          iconSize: 30,
                          elevation: 16,
                          underline: Container(
                            height: 0,
                            color: Theme.of(context).primaryColor,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueProduce = newValue;
                            });
                          },
                          items: <String>['Select Produce', 'Produce Two', 'Produce Free', 'Produce Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          /*items: _dropdownValues
                            .map((value) => DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                ))
                            .toList(),*/
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: dropdownValueFarm,
                          icon: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,8,0),
                            child: Icon(
                              Icons.arrow_drop_down_circle,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          isExpanded: true,
                          iconSize: 30,
                          elevation: 16,
                          underline: Container(
                            height: 0,
                            color: Theme.of(context).primaryColor,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueFarm = newValue;
                            });
                          },
                          items: <String>['Select Farm', 'Farm Two', 'Farm Free', 'Farm Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          /*items: _dropdownValues
                            .map((value) => DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                ))
                            .toList(),*/
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        child: _button("REGISTER", Colors.white, primary,
                            primary, Colors.white, _registerFarmProduce),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
      ),
    );;
  }
}
