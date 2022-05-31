import 'package:flutter/material.dart';
import 'package:testproject/breakfast1.dart';
import 'package:testproject/breakfast2.dart';

void main() {
  runApp(
     const MaterialApp(
      home: Page1(),
       debugShowCheckedModeBanner: false,
    ),
  );
}

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typeRadioGroup = _TypeRadioGroup(GlobalKey<_TypeRadioGroupState>());

    final btn = ElevatedButton(
      child: const Text('Go!'),
      onPressed: (){
        if( typeRadioGroup.getSelectedItem() == _TypeRadioGroup.breakfast){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BreakFastPage()));
        }else{
          if(typeRadioGroup.getSelectedItem() == _TypeRadioGroup.pasta){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PastaPage()));
          }else{
            if(typeRadioGroup.getSelectedItem() == _TypeRadioGroup.rice){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RicePage()));
            }else{
              if(typeRadioGroup.getSelectedItem() == _TypeRadioGroup.drink){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrinkPage()));
              }
            }
          }
        }
      },
    );

    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50,horizontal: 80),
            alignment: Alignment.centerLeft,
            child: const Text('吃飯種類:', style: TextStyle(fontSize: 20)),
          ),
          Container(
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: typeRadioGroup,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: btn,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: widget,
    );
  }

}

class _TypeRadioGroup extends StatefulWidget{
  final GlobalKey<_TypeRadioGroupState> _key;
  static const breakfast = '早餐',
              pasta = '義大利麵',
              rice='便當',
              drink='飲料';
  const _TypeRadioGroup(this._key):super(key: _key);
  @override
  State<StatefulWidget> createState() => _TypeRadioGroupState();
  getSelectedItem()=>_key.currentState?.getSelectedItem();
}

class _TypeRadioGroupState extends State<_TypeRadioGroup>{
  final _types = const <String>[
    _TypeRadioGroup.breakfast,
    _TypeRadioGroup.pasta,
    _TypeRadioGroup.rice,
    _TypeRadioGroup.drink,
  ];
  var _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    var radioItems = <RadioListTile>[];
    for(var i = 0; i< _types.length; i++){
      radioItems.add(RadioListTile(
          value: i,
          groupValue: _groupValue,
          title: Text(_types[i],style: TextStyle(fontSize: 20),),
          onChanged:(value) {
            _updateGroupValue(value);
          }));
    }
    final widget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioItems,
    );
    return widget;
  }

  _updateGroupValue(int groupValue){
    setState((){
      _groupValue = groupValue;
    });
  }
  getSelectedItem()=> _types[_groupValue];
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  BreakFast1(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  BreakFast2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class BreakFastPage extends StatelessWidget {
  const BreakFastPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final btn = RaisedButton(
      child: Text('重新選擇餐點'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          Card(
            child:ListTile(
              title: const Text('麥味登'),
              subtitle: const Text('大學城、水源街'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('向陽'),
              subtitle: const Text('大學城'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('兔寶寶'),
              subtitle: const Text('水源街'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(30),
            child: btn,
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(
        title: const Text('早餐餐廳'),
      ),
      body: widget,
    );
    return page;
  }
}

class PastaPage extends StatelessWidget {
  const PastaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final btn = RaisedButton(
      child: Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          Card(
            child:ListTile(
              title: const Text('吃乎意料'),
              subtitle: const Text('大學城'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('Otto Pasta'),
              subtitle: const Text('金雞母'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('Buona Pasta'),
              subtitle: const Text('金雞母、水源街'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(30),
            child: btn,
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(
        title: const Text('義大利麵餐廳'),
      ),
      body: widget,
    );
    return page;
  }
}

class RicePage extends StatelessWidget {
  const RicePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final btn = RaisedButton(
      child: const Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          Card(
            child:ListTile(
              title: const Text('醬飯屋'),
              subtitle: const Text('大學城'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('珍饌廚房'),
              subtitle: const Text('水源街'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('樂之屋'),
              subtitle: const Text('金雞母'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(30),
            child: btn,
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(
        title: const Text('飯類餐廳'),
      ),
      body: widget,
    );
    return page;
  }
}

class DrinkPage extends StatelessWidget {
  const DrinkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final btn = RaisedButton(
      child: const Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          Card(
            child:ListTile(
              title: const Text('迷客夏'),
              subtitle: const Text('大學城'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('五十嵐'),
              subtitle: const Text('大學城'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Card(
            child:ListTile(
              title: const Text('清心'),
              subtitle: const Text('水源街'),
              leading: const Icon(Icons.restaurant),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(_createRoute1());
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(30),
            child: btn,
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(
        title: const Text('飲料選擇'),
      ),
      body: widget,
    );
    return page;
  }
}

