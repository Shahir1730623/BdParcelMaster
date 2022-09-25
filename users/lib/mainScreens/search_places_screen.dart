import 'package:flutter/material.dart';
import 'package:users/assistants/request_assistant.dart';
import 'package:users/global/map_key.dart';
import 'package:users/models/predicted_places.dart';
import 'package:users/widgets/place_prediction_tile.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  List<PredictedPlaces> placesPredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async
  {
      if(inputText.length > 1){
        String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:BD";

        var responseAutoCompleteSearch = await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

        if(responseAutoCompleteSearch == "Error Occured. Failed. No Response."){
          return;
        }

        //print("this is response/result: ");
        //print(responseAutoCompleteSearch);

        if(responseAutoCompleteSearch["status"] == "OK"){
          var placePredictions = responseAutoCompleteSearch["predictions"];

          var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

          setState(() {
            placesPredictedList = placePredictionsList;
          });
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //search place ui
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: Colors.white54,
              boxShadow: [
                BoxShadow(
                  color: Colors.white54,
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0.7,
                    0.7,
                  )
                )
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  const SizedBox(height: 25.0,),

                  Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Set Pickup Location",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0,),

                  Row(
                    children: [
                      const Icon(
                        Icons.adjust_sharp,
                        color: Colors.grey,
                      ),

                      const SizedBox(height: 18.0,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (valueTyped){
                              findPlaceAutoCompleteSearch(valueTyped);
                            },
                            decoration: const InputDecoration(
                              hintText: "search here...",
                              fillColor: Colors.white54,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 11.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

          ),

          //display place predictions result
          (placesPredictedList.length > 0)
              ? Expanded(
                  child: ListView.separated(
                    itemCount: placesPredictedList.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return PlacePredictionTileDesign(
                        predictedPlaces: placesPredictedList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return const Divider(
                        height: 1,
                        color: Colors.white,
                        thickness: 1,
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
