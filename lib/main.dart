import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:pinginator/screens/settings_screen.dart';
import 'widgets/cards.dart';
import 'config.dart';
import 'services/shared_prefs.dart';
import 'content.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await getGamePreference();
  await getDarkThemePreference();
  runApp(MaterialApp(
    home: HomePage(),
  ));
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String gameName;


  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    themeManager.addListener(() {
      setState(() {});
    });
    gamePreferences.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gameName=gamePreferences.getGameName();
    return MaterialApp(
      themeMode: themeManager.getCurrentThemeMode(),
      darkTheme: themeManager.getDarkTheme(),
      theme: themeManager.getLightTheme(),
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  IconButton(icon:Icon(Icons.settings),onPressed: () async{
                    await Navigator.push(context, CupertinoPageRoute(builder: (context)=>SettingsScreen()));
                  },)
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(CommunityMaterialIcons.controller_classic),
          onPressed: (){},
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
                backgroundColor: gameMap[gameName]['themeColor'],
                expandedHeight: 200,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      left: 15,
                      top: 50,
                      child: SafeArea(child: Text("Fortnite",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: Colors.white),textAlign: TextAlign.left,),
                      ),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size(0,0),
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                        color: themeManager.homeScreenBottomContainerColor,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                    ),
                  ),
                )
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context,index){
                    return GamePingCard(gameMap[gameName]['serverNames'][index],gameMap[gameName]['serverAddresses'][index],gameMap[gameName]['themeColor']);
                  },
                childCount: gameMap[gameName]['serverNames'].length
              ),
            )
          ],
        ),
      ),
    );
  }
}

