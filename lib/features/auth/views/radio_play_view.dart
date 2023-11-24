import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio_app/common/colors.dart';
import 'package:radio_app/common/sizes.dart';
@RoutePage()
class RadioPlayView extends StatelessWidget {
  const RadioPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
          padding: scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: scaffoldPadding,
                    child: CircleAvatar(
                      backgroundColor: profilePhotoCircleColor,
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/34.jpg"),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_alert_sharp,
                        color: Colors.white,
                        size: 25,
                      ))
                ],
              ),
              Column(children: [
                Padding(
                  padding: scaffoldPadding,
                  child: AspectRatio(
                    aspectRatio: 10 / 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: Colors.blue,
                        image: DecorationImage(
                          image: AssetImage("assets/images/NumberOne.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: vertical10,
                        child: Text(
                          'FM Radyo ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Text(
                        "104.3",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: vertical10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: Icon(
                                Icons.replay,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.stop_rounded,
                                size: 100,
                                color: Colors.redAccent,
                              ),
                            ),
                            Center(
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(3.141),
                                child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Icon(
                                    Icons.replay,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.online_prediction,
                        color: Colors.white,
                        size: 50,
                      )
                    ],
                  ),
                )
              ])
            ],
          ),
        )));
  }
}
