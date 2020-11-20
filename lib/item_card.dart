import 'package:AgriView/models/Product.dart';
import 'package:AgriView/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey[200],),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0,20.0,15.0,0.0),
                    // For  demo we use fixed height  and width
                    // Now we dont need them
                     //height: 100,
                     //width: 120,
                    child: Hero(
                      tag: "${product.productID}",
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.network(product.fileName, fit: BoxFit.fill, height: 100, width: 120,),
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                    child: Text(
                      // products is out demo list
                      product.productName,
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}