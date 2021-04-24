import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TabController tabController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            SizedBox(
              height: 73,
            ),
            TabBar(
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: (17 / 13),
              ),
              unselectedLabelColor: Color(0xff959DAD),
              labelColor: Color(0xff454F63),
              tabs: [
                Tab(
                  text: 'SIGN IN',
                ),
                Tab(
                  text: 'SIGN UP',
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: TabBarView(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 44),
                  color: Color(0xffF7F7FA),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color(0x9078849E),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0x9078849E),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0x9078849E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff3ACCE1),
                      ),
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                            color: Colors.white, fontSize: 15, height: 1.333),
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 44),
                  color: Color(0xffF7F7FA),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color(0x9078849E),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0x9078849E),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0x9078849E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff3ACCE1),
                      ),
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                            color: Colors.white, fontSize: 15, height: 1.333),
                      ),
                    ),
                  ]),
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
