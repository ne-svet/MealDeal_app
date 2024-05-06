import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
                backgroundColor: Color(0xFF62BD5C),
              ),
                onPressed: (){
                  //TODO применить фильтры
                },
                child: Text("Apply", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.grey[300],
                ),
                onPressed: (){
                  //TODO отменить фильтры
                },
                child: Text("Clear all", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
            )
          ],
        ),
      ),
    );
  }
}
