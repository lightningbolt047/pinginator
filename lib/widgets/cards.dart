import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pinginator/config.dart';
import 'package:pinginator/services/ping_service.dart';
import 'dart:async';

class GamePingCard extends StatefulWidget {

  final String serverName,serverURL;
  final Color secondaryColor;

  GamePingCard(this.serverName,this.serverURL,this.secondaryColor);

  @override
  _GamePingCardState createState() => _GamePingCardState(this.serverName,this.serverURL,this.secondaryColor);
}

class _GamePingCardState extends State<GamePingCard> {



  var androidPlatform=MethodChannel('flutter.native/helper');
  String pingExecResult;
  Timer timer;
  Color secondaryColor;
  double pingTime;

  Future<String> invokeAndroidMethod() async{
    try{
      timer=Timer(Duration(seconds: 1),() async{
        print("Ping called $serverName");
        pingExecResult = await androidPlatform.invokeMethod('getPingTime',serverURL);
        print("Ping complete $serverName");
        setState(() {
          getPingAsDouble(pingExecResult);
        });
        print("Avg ping: $pingTime");
      });
      return pingExecResult;

    }catch(e){
      print(e);
      return "Platform Exception";
    }
  }

  final serverName,serverURL;
  List<double> responseTimes=[];
  double lastResponseTime=0;

  _GamePingCardState(this.serverName,this.serverURL,this.secondaryColor);

  void getPingAsDouble(String pingExecResult){
    List<String> lineByLineResponse=pingExecResult.split("\n");
    if(lineByLineResponse.length<11){
      pingTime=-1;
      return;
    }
    pingTime=double.parse(lineByLineResponse[9].split("/")[4]);
  }


  int getIntAverage(){
    if(pingTime==-1 || pingTime==null){
      return 0;
    }
    return pingTime.toInt();
  }

  int getProgressBarValue(bool forProgressBar){
    if(getIntAverage()>500 && forProgressBar){
      return 500;
    }
    return getIntAverage();
  }

  Widget getValueTextWidget(){
    if(pingTime==null){
      return Text("Loading...");
    }
    return Text(pingTime==-1?"Fail":"${getProgressBarValue(false)}ms");
  }


  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    invokeAndroidMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _fullSize=MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(serverName,style: TextStyle(fontSize: 30),),
            SizedBox(
              height: _fullSize.height*0.01,
            ),
            Text(serverURL,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey),),
            SizedBox(
              height: _fullSize.height*0.02,
            ),
            Row(
              children: [
                Expanded(
                  child: FAProgressBar(
                    currentValue: getProgressBarValue(true),
                    maxValue: 500,
                    progressColor: Colors.purple,
                    size: 10,
                  ),
                ),
                getValueTextWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
