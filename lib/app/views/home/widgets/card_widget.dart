import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardWidget extends StatefulWidget {
  final String iconImg;
  final String titleCard;
  final IconData iconData;
  final Function onTap;
  
  const CardWidget({Key key, 
    this.iconImg, 
    this.titleCard = '', 
    this.iconData, 
    this.onTap}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
  
    return Container(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Hero(
          tag: 'imageHero-${widget.titleCard}',
          child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: _size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(widget.iconImg),
                          fit: BoxFit.contain,
                        )
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(widget.iconData,
                                  color: Colors.grey,
                                ),
                              ),
                             
                              Expanded(
                                flex: 2,
                                child: Text('${widget.titleCard}',
                                textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              
                            ]
                          ),
                        ),
                        
                        ButtonBar(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.arrowRight,
                              size: 32,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}