import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/pages/home/home_page.dart';

// ignore: must_be_immutable
class ConnectionStats extends StatefulWidget {
  ConnectionStats(this.parent, {Key key}) : super(key: key);

  HomePageState parent;

  @override
  ConnectionStatsState createState() => ConnectionStatsState();
}

class ConnectionStatsState extends State<ConnectionStats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("00:15:02",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: AppColors.grayColor,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
          child: TextButton(
              onPressed: () {
                widget.parent.checkHasLogin(() => widget.parent.selectServerNode());
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(MaterialCommunityIcons.map_marker,
                    color: AppColors.grayColor, size: 20),
                Text("other nodes",
                    style:
                        TextStyle(fontSize: 12, color: AppColors.grayColor)),
                Icon(Icons.chevron_right, color: AppColors.grayColor, size: 20)
              ])),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(75), vertical: 10),
          child: Row(
            children: [
              // Download Stats

              Row(children: [
                // Download Icon
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xffff0000),
                            blurRadius: 13,
                            spreadRadius: -2)
                      ],
                      color: const Color(0xffff0000),
                      borderRadius: BorderRadius.circular(13)),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                ),

                // Labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Downlink speed",
                        style: TextStyle(
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: AppColors.grayColor,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: "75.9"),
                              TextSpan(
                                  text: " KB/s",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ]),
                      )
                    ],
                  ),
                )
              ]),

              Expanded(child: Container()),

              // Upload Stats
              Row(children: [
                // Upload Icon
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xff03a305),
                            blurRadius: 13,
                            spreadRadius: -2)
                      ],
                      color: const Color(0xff03a305),
                      borderRadius: BorderRadius.circular(13)),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),

                // Labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Up speed",
                        style: TextStyle(
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: AppColors.grayColor,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: "29.6"),
                              TextSpan(
                                  text: " KB/s",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ]),
                      )
                    ],
                  ),
                )
              ]),
            ],
          ),
        )
      ],
    );
  }
}
