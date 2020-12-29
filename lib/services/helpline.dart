import 'package:expandable/expandable.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/accordian/gf_accordian.dart';
import 'package:project/themedata/themes.dart';
import 'package:project/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String c)async{
  if(await canLaunch("tel:"+c)){
    await launch("tel:"+c);
  }
  else{
    AlertDialog(content: Text("Unable to call at the current moment."),);
  }
}

String centralHelpline = "+91-11-23978046";

class Helpline extends StatelessWidget {
  static const String tag = 'helpline';
  
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: helplineColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Select Your State', style: TextStyle(fontSize: 18, color: Colors.white),),
            InkWell(
              onTap: (){
                _launchURL(centralHelpline);
              },
              child: Row(
                children: <Widget>[
                  Text("National\nHelpline", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),),
                  SizedBox(width: 5,),
                  Icon(Icons.call, size: 40, color: Colors.white),
                ],
              ), 
            ), 
          ],
        ),
      ),
      drawer: showDrawer(context),
      body: ListView.builder(
        itemCount: globalContacts.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int i){
          return GFAccordion(
            titleChild:Text(
              globalContacts[i][0],
              style: TextStyle(
                //color: GFColors.LIGHT, 
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
            contentChild: Container(
            height: (40*globalContacts[i].length).toDouble(),
            child:ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: globalContacts[i].length-1,
              itemBuilder: (BuildContext c, int ind){
                return FlatButton.icon(
                  icon: Icon(Icons.call),
                  label: Text(globalContacts[i][ind+1], style: TextStyle(color: Colors.black, fontSize: 20),),
                  onPressed: (){
                    _launchURL(globalContacts[i][ind+1]);
                    print("button pressed, calling some number");
                  },
                  );
              },
            )
          )
          );        
        }
      )
    );
  }
}

// contact information
List<List<String>> globalContacts = [
  ["Andaman and Nicobar", "03192-232102", "03192-234287", ],
  ["Andhra Pradesh", "0866-2410978", ],
  ["Arunachal Pradesh", "104", ],
  ["Assam", "104", ],
  ["Bihar", "0612-2217681", "0612-2233806", "104", ],
  ["Chandigarh", "0172-2752038", "0172-2752031", "0172-2704048", ],
  ["Chhattisgarh", "0771-282113", "0771-2446607", "0771-2440608", ],
  ["Dadra and Nagar Haveli", "104", "1077", "0260-2642106", "0260-2630304", ],
  ["Daman and Diu", "104", "1077", "0260-2642106", "0260-2630304", ],
  ["Delhi", "011-22307145", ],
  ["Goa", "104", ],
  ["Gujarat", "079-23251900", "079-23251908", "104", ],
  ["Haryana", "0172-2545938", ],
  ["Himachal Pradesh", "077-2628940", "077-2629439", "104", ],
  ["Jammu and Kashmir", "0191-2549676", "0191-2520982", "0194-2440283", "0194-2452052", "0194-2457313", ],
  ["Jharkhand", "0651-2282201", "0651-2284185", "0651-223488", "181", "104", ],
  ["Karnataka", "080-46848600", "1075", "104", ],
  ["Kerala", "0471-2552056", "0471-25521056", ],
  ["Ladakh", "01982-256462", "01982-257416", "01982-258960", ],
  ["Lakshadweep", "104","04896-263742", ],
  ["Maharashtra", "022-22024535", ],
  ["Manipur", "1800-345-3818", ],
  ["Meghalaya", "108", "0364-2224100", "0364-2590623", ],
  ["Mizoram", "102", ],
  ["Madhya Pradesh", "104", "1075", "181","0755-2411180","0755-2704201", "0729-22344", ],
  ["Nagaland", "0370-2291122", "0370-2270338", ],
  ["Odisha", "104", "0674-2534177", ],
  ["Puducherry", "104", "1070", "1077", "0413-2253407", ],
  ["Punjab", "104", ],
  ["Rajasthan", "0141-2225000", "0141-2225624", ],
  ["Sikkim", "104", "03592-284444", ],
  ["Tamil Nadu", "0471-2552056", "0471-25521056", ],
  ["Telengana", "104", "040-23286100", ],
  ["Tripura", "0381-2315879", "0381-2412424", "0381-2413434", ],
  ["Uttar Pradesh", "0522-2237515", ],
  ["Uttarakhand", "104", ],
  ["West Bengal", "1800-313-444222", "033-23412600", ],
];
