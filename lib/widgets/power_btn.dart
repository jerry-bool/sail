import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/pages/home/home_page.dart';

class PowerButton extends StatefulWidget {
  const PowerButton(this.parent, {Key key}) : super(key: key);
  final HomePageState parent;

  @override
  PowerButtonState createState() => PowerButtonState();
}

class PowerButtonState extends State<PowerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.parent.isOn? const Color(0x20000000): const Color(0xff606060),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(80)),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(80)),
        color: widget.parent.isOn? AppColors.grayColor: Colors.grey,
        child: InkWell(
          splashColor: AppColors.yellowColor,
          onTap: (){
            widget.parent.checkHasLogin(() => widget.parent.pressConnectBtn());
          },
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(80)),
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
            child: Icon(
              Icons.power_settings_new,
              size: ScreenUtil().setWidth(120),
              color: Colors.white,
            )
          ),
        ),
      ),
    );
  }
}
