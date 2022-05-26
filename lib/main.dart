import 'package:flutter/material.dart';
import 'package:testproject/breakfast1.dart';
import 'package:testproject/breakfast2.dart';

void main() {
  runApp(
     MaterialApp(
      home: Page1(),
    ),
  );
}

class Page1 extends StatelessWidget {
  //const Page1({super.key});

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
        //_navigateToNextScreen(context);
        //Navigator.of(context).push(_createRoute());
      },
    );

    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(
            child: Text('吃飯種類:', style: TextStyle(fontSize: 20)),
            margin: EdgeInsets.symmetric(vertical: 50,horizontal: 80),
            alignment: Alignment.centerLeft,
          ),
          Container(
            child: typeRadioGroup,
            width: 200,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: btn,
            margin: EdgeInsets.symmetric(vertical: 40),
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
  //const BreakFastPage({super.key});

  @override
  Widget build(BuildContext context) {

    final textWrapper = _TextWrapper(GlobalKey<_TextWrapperState>());

    const items = <String>['麥味登', '向陽', '兔寶寶'];
    final List<IconData> icons = [Icons.restaurant,Icons.restaurant,Icons.restaurant,];

    var listView = ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) =>
          Card(
            child:ListTile(title: Text(items[index],style: TextStyle(fontSize: 20),),
              onTap: () {
                if(items[index] == '麥味登'){
                  Navigator.of(context).push(_createRoute());
                }else{
                  if(items[index] == '向陽'){
                    Navigator.of(context).push(_createRoute1());
                  }
                }
              },
              leading: Container(
                child: Icon(icons[index]),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),),
              subtitle: Text('項目說明',style: TextStyle(fontSize: 16),),),
          ),

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    final btn = RaisedButton(
      child: Text('重新選擇餐點'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          textWrapper,
          Expanded(child: listView,),
          Container(
            child: btn,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(),
      body: widget,
    );
    return page;
  }
}

class _TextWrapper extends StatefulWidget {
  final GlobalKey<_TextWrapperState> _key;

  _TextWrapper(this._key): super (key: _key);

  State<StatefulWidget> createState() => _TextWrapperState();

  setText(String string) {
    _key.currentState?.setText(string);
  }
}

class _TextWrapperState extends State<_TextWrapper> {
  String _str = '';

  Widget build(BuildContext context) {
    var widget = Text(
      _str,
      style:  TextStyle(fontSize: 20),
    );

    return widget;
  }

  setText(String string) {
    setState(() {
      _str = string;
    });
  }
}

class PastaPage extends StatelessWidget {
  //const PastaPage({super.key});

  @override
  Widget build(BuildContext context) {

    final textWrapper = _TextWrapper(GlobalKey<_TextWrapperState>());

    const items = <String>['吃乎意料', 'Otto Pasta','Buona Pasta'];
    final List<IconData> icons = [Icons.restaurant,Icons.restaurant,Icons.restaurant,];

    var listView = ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) =>
          Card(
            child:ListTile(title: Text(items[index],style: TextStyle(fontSize: 20),),
              onTap: () => textWrapper.setText('點選'+items[index]),
              leading: Container(
                child: Icon(icons[index]),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),),
              subtitle: Text('項目說明',style: TextStyle(fontSize: 16),),),
          ),

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    final btn = RaisedButton(
      child: Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          textWrapper,
          Expanded(child: listView,),
          Container(
            child: btn,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(),
      body: widget,
    );
    return page;
  }
}

class RicePage extends StatelessWidget {
  //const RicePage({super.key});

  @override
  Widget build(BuildContext context) {

    final textWrapper = _TextWrapper(GlobalKey<_TextWrapperState>());

    const items = <String>['椒麻雞大王','樂之屋','極簡主義'];
    final List<IconData> icons = [Icons.restaurant,Icons.restaurant, Icons.restaurant];

    var listView = ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) =>
          Card(
            child:ListTile(title: Text(items[index],style: TextStyle(fontSize: 20),),
              onTap: () => textWrapper.setText('點選'+items[index]),
              leading: Container(
                child: Icon(icons[index]),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),),
              subtitle: Text('項目說明',style: TextStyle(fontSize: 16),),),
          ),

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    final btn = RaisedButton(
      child: Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          textWrapper,
          Expanded(child: listView,),
          Container(
            child: btn,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(),
      body: widget,
    );
    return page;
  }
}

class DrinkPage extends StatelessWidget {
  //const DrinkPage({super.key});

  @override
  Widget build(BuildContext context) {

    final textWrapper = _TextWrapper(GlobalKey<_TextWrapperState>());

    const items = <String>['迷客夏','五十嵐','清心'];
    final List<IconData> icons = [Icons.wine_bar, Icons.wine_bar,Icons.wine_bar];

    var listView = ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) =>
          Card(
            child:ListTile(title: Text(items[index],style: TextStyle(fontSize: 20),),
              onTap: () => textWrapper.setText('點選'+items[index]),
              leading: Container(
                child: Icon(icons[index]),
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),),
              subtitle: Text('項目說明',style: TextStyle(fontSize: 16),),),
          ),

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    final btn = RaisedButton(
      child: Text('回到上一頁'),
      onPressed: ()=> Navigator.pop(context),
    );

    final widget = Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children:  [
          textWrapper,
          Expanded(child: listView,),
          Container(
            child: btn,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );

    final page = Scaffold(
      appBar: AppBar(),
      body: widget,
    );
    return page;
  }
}

