import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_app/common/colors.dart';
import 'package:radio_app/common/sizes.dart';
import 'package:radio_app/features/auth/views/radio.dart';
import 'package:radio_app/widgets/expandable.dart';

import 'package:radio_app/widgets/player.dart';
import 'package:radio_app/widgets/radio_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  dynamic radioClass;
  bool isPlaying = false;
  final _controller = ScrollController();
  double offset = 0;
  late double _percentageOpen = 0;
  String radioTitle = 'Select Channel';
  String radioListener = 'Select Channel';
  String radioImageURl = '';
  bool isPlayCardVisible = false;
  dynamic currentlyPlaying;
  List<dynamic> stationList = [];
  List<String>? metadata;

  @override
  void initState() {
    super.initState();
    _controller.addListener(moveOffset);
    radioClass = RadioClass();
    readJson();
  }

  @override
  void dispose() {
    super.dispose();
    radioClass.stop();
  }

  moveOffset() {
    setState(() {
      offset = min(max(0, _controller.offset / 6 - 16), 32);
    });
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/station.json');
    List<dynamic> data = json.decode(response);

    setState(() {
      stationList.addAll(data);
    });
  }

  Future<void> radioPlayer(item) async {
    currentlyPlaying = item;
    radioClass.stop();

    setState(() {
      radioClass.setChannel(item);
    });

    radioClass.radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    radioClass.radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });

    setState(() {
      isPlayCardVisible = true;
      radioTitle = item['name'];
      radioImageURl = item['imageURL'];
      radioListener = item['listener'];

      stationList.asMap().forEach((index, items) {
        if (items == item) {
          if (item['isPlay'] == true) {
            stationList[index]['isPlay'] = false;
            radioClass.pause();
          } else {
            stationList[index]['isPlay'] = true;
            Future.delayed(
              const Duration(seconds: 1),
              () => radioClass.play(),
            );
          }
        } else {
          stationList[index]['isPlay'] = false;
        }
      });
    });
  }

  Future<void> play() async {
    radioClass.play();
    checkStation();
  }

  Future<void> pause() async {
    radioClass.pause();
    checkStation();
  }

  void checkStation() {
    stationList.asMap().forEach((index, items) {
      if (items == currentlyPlaying) {
        if (currentlyPlaying['isPlay'] == true) {
          stationList[index]['isPlay'] = false;
          radioClass.pause();
        } else {
          stationList[index]['isPlay'] = true;
          Future.delayed(
            const Duration(seconds: 1),
            () => radioClass.play(),
          );
        }
      } else {
        stationList[index]['isPlay'] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: ExpandableBottomSheet(
        background: CustomScrollView(
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: scaffoldPadding,
                    child: CircleAvatar(
                        backgroundColor: profilePhotoCircleColor,
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/profiledu.png")),
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
              primary: true,
              pinned: true,
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                child: Text('Radio List',
                    style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = stationList[index];

                      return Container(
                          alignment: Alignment.center,
                          width: 300,
                          child: Center(
                              child: RadioCard(
                                  onTab: () => radioPlayer(item), item: item)));
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Text('Radio Playing',
                  style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
                child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Now Listening',
                          style: TextStyle(color: whiteColor, fontSize: 18),
                        ),
                      ),
                      Text(
                        radioTitle,
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Text(
                        radioListener,
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
                            IconButton(
                              color: Colors.red,
                              onPressed: () => isPlaying ? pause() : play(),
                              icon: Icon(
                                isPlaying ? Icons.stop : Icons.play_arrow,
                                size: 40,
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
            )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 70,
              ),
            ),
          ],
        ),
        onIsContractedCallback: () => print('contracted'),
        onIsExtendedCallback: () => print('extended'),
        persistentContentHeight: 64,
        expandableContent: isPlayCardVisible
            ? Player(
                title: radioTitle,
                listener: radioListener,
                imageURL: radioImageURl,
                percentageOpen: _percentageOpen,
                onTab: () => isPlaying ? pause() : play(),
                icon:
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                metadata: metadata,
              )
            : const SizedBox(),
        onOffsetChanged: (offset, minOffset, maxOffset) {
          if (isPlayCardVisible) {
            if (maxOffset == null || offset == null || minOffset == null) {
              return;
            }
            final range = maxOffset - minOffset;
            final currentOffset = offset - minOffset;
            setState(() {
              _percentageOpen = max(0, 1 - (currentOffset / range));
            });
          }
        },
        enableToggle: true,
        isDraggable: true,
      ),
    );
  }
}
