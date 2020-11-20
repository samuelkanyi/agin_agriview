import 'package:flutter/material.dart';

class FarmDetail extends StatelessWidget {
    Color color;

  @override
  Widget build(BuildContext context) {
    color = Theme.of(context).primaryColor;
    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String farmerAginID = data['farmerAginID'].toString();
    String aggregatorAginID = data['aggregatorAginID'].toString();
    String landAginID = data['landAginID'].toString();
    String farm_name = data['farm_name'].toString();
    String farm_location = data['farm_location'].toString();
    String acreage_mapped = data['acreage_mapped'].toString();
    String acreage_approved = data['acreage_approved'].toString();


    final height = MediaQuery.of(context).size.height / 2.3;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color,
        title: Text('Farm Info'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            buildTop(height, width, farm_name, farm_location, acreage_mapped, acreage_approved),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        buildOption('assets/images/produce_grey.png', 'Produce', false, context, farm_name, landAginID,farmerAginID,aggregatorAginID, '/producelist'),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        /* buildOption('', '', false, context,'','',''),
                        buildOption('', '', false, context,'','',''),
                        buildOption('', '', false, context,'','',''),
                        buildOption(Icons.code, 'QR Code', false),
                        buildOption(Icons.pie_chart, 'Daily bonus', false),
                        buildOption(Icons.remove_red_eye, 'Visitors', false),*/
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTop(double height, double width, String farm_name, String farm_location, String acreage_mapped, String acreage_approved) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: height * 0.7,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Container(
                  width: width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Acreage Mapped',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '12',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),*/
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage('assets/images/farm_grey.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        '$farm_location',
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  ),
                ),
                /*Container(
                  width: width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Produce',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '18',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(0.0),
            child: Text(
              farm_name,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /*Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildOption(Icons.group_add, "Friends", true),
                buildOption(Icons.group, "Groups", true),
                buildOption(Icons.videocam, "Videos", true),
                buildOption(Icons.favorite, "Likes", true),
              ],
            ),
          ),*/
          Spacer(),
        ],
      ),
    );
  }

  Widget buildOption(String image, String text, bool top,BuildContext context,String farm_name, String landAginID,String farmerAginID,String aggregatorAginID,String nextLink) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: (){

            if(nextLink == '/producelist'){
              Map map = {'landAginID':landAginID, 'name' : farm_name, 'farmerAginID':farmerAginID, 'aggregatorAginID':aggregatorAginID};
              Navigator.pushNamed(context, nextLink,arguments: map);
            }

          },
          child: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.75)
                )
              ],
              color: Colors.white,
              border: Border.all(
                color: Colors.grey[200],
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child:  Image.asset(
              image,
              scale: 12,
            ),
            /* child: Icon(
              new IconData(),
              size: 37.0,
              color: top ? Colors.white : Colors.grey,
            ),*/
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              color: top ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
