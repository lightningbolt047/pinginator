import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pinginator/config.dart';
import 'package:pinginator/services/ping_service.dart';

class GamePingCard extends StatefulWidget {

  final String serverName,serverURL;

  GamePingCard(this.serverName,this.serverURL);

  @override
  _GamePingCardState createState() => _GamePingCardState(this.serverName,this.serverURL);
}

class _GamePingCardState extends State<GamePingCard> {

  final serverName,serverURL;
  List<double> responseTimes=[];
  double lastResponseTime=0;

  _GamePingCardState(this.serverName,this.serverURL);

  void keepPinging() async{
    for(int i=0;i<maxNumPings;i++){
      lastResponseTime=await ping(serverURL);
      responseTimes.add(lastResponseTime);
      print(lastResponseTime);
      setState(() {});
    }
  }

  int getIntAverage(){
    double avg=0;
    for(int i=0;i<maxNumPings;i++){
      avg+=responseTimes[i];
    }
    avg/=maxNumPings;
    return avg.toInt();
  }

  int getProgressBarValue(bool forProgressBar){
    if(responseTimes.length==maxNumPings){
      if(getIntAverage()>500 && forProgressBar){
        return 500;
      }
      return getIntAverage();
    }
    if(lastResponseTime>500 && forProgressBar){
      return 500;
    }
    return lastResponseTime.toInt();
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    keepPinging();
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
                Text("${getProgressBarValue(false)}ms")
              ],
            )
          ],
        ),
      ),
    );
  }
}
