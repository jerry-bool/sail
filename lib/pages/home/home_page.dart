import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/flutter_vpn_platform_interface.dart';
import 'package:flutter_vpn/state.dart';
import 'package:fluttertoast/fluttertoast.dart';
=======
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/models/app_model.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/pages/plan/plan_page.dart';
import 'package:sail_app/pages/server_list.dart';
import 'package:sail_app/widgets/home_widget.dart';
import 'package:sail_app/widgets/power_btn.dart';

typedef Callback = Future<void> Function();

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  AppModel _appModel;
  ServerModel _serverModel;
  UserModel _userModel;
  UserSubscribeModel _userSubscribeModel;
  bool _isLoadingData = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _appModel = Provider.of<AppModel>(context);
    _userModel = Provider.of<UserModel>(context);
    _userSubscribeModel = Provider.of<UserSubscribeModel>(context);
    _serverModel = Provider.of<ServerModel>(context);

    if (_userModel.isLogin && !_isLoadingData) {
      _isLoadingData = true;
      await _userSubscribeModel.getUserSubscribe();
      await _serverModel.getServerList(forceRefresh: true);
      await _serverModel.getSelectServer();
      await _serverModel.getSelectServerList();
    }
  }

<<<<<<< HEAD
  Future<void> pressConnectBtn() async {
    if (_serverModel.selectServerEntity == null) {
      Fluttertoast.showToast(
          msg: "Please select a server node",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }

    await vpnManager.enableVPNManager();
    vpnManager.enableVPNManager().asStream();

    setState(() {
      isOn = !isOn;

      if (isOn) {
        print(_serverModel.selectServerEntity.toJson());
      }
    });
  }

  Future<void> changeBoughtPlanId(id) async {
    NavigatorUtil.goPlan(context);
    // _userSubscribeModel.getUserSubscribe();
  }

  Future<void> selectServerNode() async {
    await NavigatorUtil.goServerList(context);
  }

  Future<void> checkHasLogin(Callback callback) async {
    if (!_userModel.isLogin) {
      NavigatorUtil.goLogin(context);
    } else {
      return callback();
    }
  }

=======
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _appModel.isOn ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Scaffold(
            extendBody: true,
            backgroundColor: _appModel.isOn ? AppColors.yellowColor : AppColors.grayColor,
            body: SafeArea(
                bottom: false,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    const HomeWidget(),
                    const PlanPage(),
                    const ServerListPage(),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: ScreenUtil().screenHeight,
                        child: const Center(
                          child: Text('datadatadata'),
                        ),
                      ),
                    )
                  ],
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const PowerButton(),
            bottomNavigationBar: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setWidth(0)),
                    topRight: Radius.circular(ScreenUtil().setWidth(0))),
                child: BottomAppBar(
                  notchMargin: 4,
                  shape: const CircularNotchedRectangle(),
                  color: _appModel.isOn ? AppColors.grayColor : AppColors.themeColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _pageController.jumpToPage(0);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _pageController.jumpToPage(1);
                          });
                        },
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setHeight(50),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.print,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _pageController.jumpToPage(2);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _pageController.jumpToPage(3);
                          });
                        },
                      )
                    ],
                  ),
                ))));
  }
}
