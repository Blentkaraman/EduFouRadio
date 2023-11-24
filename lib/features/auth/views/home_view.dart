import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:radio_app/common/colors.dart';
import 'package:radio_app/common/sizes.dart';
import 'package:radio_app/routes/app_route.dart';
import 'package:radio_app/widgets/sub_title_widget.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                const Padding(
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
                  icon: const Icon(
                    Icons.add_alert_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
            Padding(
              padding: vertical10,
              child: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: searchColor,
                    hintText: "Search",
                    hintStyle: TextStyle(color: whiteColor),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: vertical10),
              ),
            ),
            const SubTittleWidget(
              title: "Favorite Radios",
              size: 15,
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AspectRatio(
                      aspectRatio: 16 / 11,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //color: Colors.blue,
                          image: const DecorationImage(
                            image: AssetImage("assets/images/NumberOne.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Play",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SubTittleWidget(
              title: "Play Radios",
              size: 20,
            ),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: () {
                  context.router.push(RadioPlayRoute());
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: textButtonColorLight,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Now Listening',
                          style: TextStyle(color: whiteColor, fontSize: 18),
                        ),
                      ),
                      Text(
                        "104.3",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Text(
                        "Fm-Radyo",
                        style: TextStyle(color: whiteColor, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: whiteColor,
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
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: Icon(
                                Icons.radio,
                                size: 30,
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
