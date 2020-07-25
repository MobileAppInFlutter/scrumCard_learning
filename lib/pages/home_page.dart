import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fibonacci = [0, 1, 2, 3, 5, 8, 13, 20, 40, 100];
  var isHomePage = true;
  var singleCardText = "";
  var singleCardIcon;

  switchToCard(text, icon) {
    setState(() {
      isHomePage = false;
      singleCardText = text;
      singleCardIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedSwitcher(
         duration: Duration(milliseconds: 300),
              child: isHomePage
            ? GridView.count(
                crossAxisCount: 3,
                children: <Widget>[
                  ScrumCard(text: "", icon: Icon(Icons.free_breakfast)),
                  for (var i in fibonacci)
                    ScrumCard(
                      text: i.toString(),
                      notifyParent: switchToCard,
                    ),
                  ScrumCard(
                    text: "",
                    icon: Icon(Icons.all_inclusive),
                  )
                ],
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                padding: EdgeInsets.all(10.0),
              )
            : Padding(
                padding: EdgeInsets.all(10.0),
                child: ScrumCard(
                  text: singleCardText,
                  icon: singleCardIcon,
                  notifyParent: (text, icon) {
                    setState(() {
                      singleCardIcon = null;
                      singleCardText = "";
                      isHomePage = true;
                    });
                  },
                ),
              ),
      ),
    );
  }
}

class ScrumCard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function(String text, Icon icon) notifyParent;

  const ScrumCard({Key key, this.text, this.icon, this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notifyParent(text, icon);
      },
      child: Card(
        child: Center(
            child: icon == null
                ? Text(
                    text,
                    style: TextStyle(fontSize: 38.0),
                  )
                : icon),
      ),
    );
  }
}
