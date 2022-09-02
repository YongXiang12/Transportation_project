import 'package:flutter/material.dart';

import 'GoogleMapChangeNotify.dart';
import 'PlaceSearch.dart';
import 'package:provider/provider.dart';

class GoogleSearch extends StatefulWidget{

  @override
  _GoogleSearch createState() => _GoogleSearch();


}

List<PlaceSearch> Result = [];

class _GoogleSearch extends State<GoogleSearch>{

 // GoogleMapChangeNotify Notify = new GoogleMapChangeNotify();
  @override
  Widget build(BuildContext context) {

    final GoogleMapChangeNotify Notify = Provider.of<GoogleMapChangeNotify>(context);

    //Notify.searchPlace(str);
    return Scaffold(

      body: ListView(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        children: [
          TextField(

            decoration: InputDecoration(

              // put the search icon in the Textfield
              prefixIcon: Icon(Icons.search,size:30),
              // adjust the content location with contentPadding
              contentPadding: EdgeInsets.only(bottom:10),
              // Textfield Background , and filled is must be true
              fillColor:  Colors.white,
              filled: true,
              // adjust the textfield outward => outlineInputBorder

              border: OutlineInputBorder(
                // rounded corner
                borderRadius:BorderRadius.all(Radius.circular(25.0),
                ),
              ),
            ),

            // adjust the Text
            style: TextStyle(
                fontSize: 25
            ),
            onChanged: (value){
                      Notify.searchPlace(value);
            },
          ),
          if(Notify.result.length!=0 && Notify.result!=null)
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: Notify.result.length,
              itemBuilder: (context , index ){
                return ListTile(
                    title: Text(Notify.result[index].name ,style: TextStyle(fontSize: 25)),
                    onTap: (){
                      Navigator.pop(context , Notify.result[index].placeId);

                    },

                );
              },

            ),
          )

        ],
      ),


    );
  }

}
