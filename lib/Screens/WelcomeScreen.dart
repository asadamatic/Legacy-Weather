import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  final Function selectScreen;
  WelcomeScreen({Key key, this.selectScreen}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  int currentPage = 0;
  final pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
            )
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              bottom: 50.0,
              top: 10.0,
              width: MediaQuery.of(context).size.width,
              right: 0.0,
              child: PageView(
                allowImplicitScrolling: true,
                onPageChanged: (index){
                  setState(() {
                    currentPage = index;
                  });
                },
                pageSnapping: true,
                controller: pageController,
                children: <Widget>[
                  Container(
                      color: Theme.of(context).accentColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image(
                            image: AssetImage('Assets/rain.png'),
                            height: 350.0,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(

                              children: <Widget>[
                                Text('WEATHER UPDATES', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Theme.of(context).primaryColor),),
                                SizedBox(height: 8.0,),
                                Text('See current temperature & humidity', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0, color: Theme.of(context).primaryColor),),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      color: Theme.of(context).accentColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image(
                            image: AssetImage('Assets/cold.png'),
                            height: 350.0,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(

                              children: <Widget>[
                                Text('WEATHER FORECAST', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Theme.of(context).primaryColor),),
                                SizedBox(height: 8.0,),
                                Text('Weather forecast for up to 5 days coming soon.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0, color: Theme.of(context).primaryColor),),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      color: Theme.of(context).accentColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image(
                            image: AssetImage('Assets/sunny.png'),
                            height: 350.0,
                            fit: BoxFit.contain,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('MULTIPLE LOCATIONS', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Theme.of(context).primaryColor),),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RaisedButton(
                                        child: Text("Choose Location", style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),),
                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                        textColor: Colors.white,
                                        color: Theme.of(context).primaryColor.withOpacity(.7),
                                        shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        onPressed: (){
                                            widget.selectScreen();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Indicator(
                      positionIndex: 0,
                      currentPage: currentPage,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Indicator(
                      positionIndex: 1,
                      currentPage: currentPage,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Indicator(
                      positionIndex: 2,
                      currentPage: currentPage,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Visibility(
                visible: currentPage < 2 ? true : false,
                child: FlatButton(
                  child: Text('Next', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),),
                  onPressed: (){
                    pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentPage;
  const Indicator({this.currentPage, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color: positionIndex == currentPage
              ? Theme.of(context).primaryColor
              : Color(0xff01286a).withOpacity(.3),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
