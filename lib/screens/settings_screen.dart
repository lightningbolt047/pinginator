import 'package:flutter/material.dart';
import 'package:pinginator/config.dart';
import 'package:pinginator/services/shared_prefs.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeManager.getLightTheme(),
      darkTheme: themeManager.getDarkTheme(),
      themeMode: themeManager.getCurrentThemeMode(),
      home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 150,
                backgroundColor: themeManager.currentSecondaryColor,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Settings")
                ),
                elevation: 3,
                forceElevated: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SwitchListTile(
                      title: Text("Dark Theme"),
                      value: themeManager.getDarkThemeValue(),
                      subtitle: themeManager.getDarkThemeValue()?Text("To the...\"Bright side\"....I guess?"):Text("🎶🎶 To the Dark Side...🎶🎶"),
                      onChanged: (bool value) async{
                        setState(() {
                          themeManager.setDarkThemeValue(value);
                        });
                        setDarkThemePreference(themeManager.getDarkThemeValue());
                      },
                      secondary: Icon(Icons.lightbulb_outline),
                    ),
                  ]
                ),
              ),
            ],
          )
      ),
    );
  }
}
