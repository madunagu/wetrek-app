import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/widgets/dotted_tab_bar.dart';

class MyButton extends StatelessWidget {
  MyButton(
    this.text, {
    this.onTap,
    this.isLarge = false,
    this.isLoading = false,
    this.color = const Color(0xff3ACCE1),
  });
  final String text;
  final VoidCallback? onTap;
  final bool isLarge;
  final Color color;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isLarge ? 52 : 44,
        alignment: Alignment.center,
        width: double.infinity,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Opacity(
          opacity: isLoading ? 0.3 : 1,
          child: Text(
            text,
            style: isLarge
                ? TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )
                : TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 17 / 13,
                  ),
          ),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

class GradientLine extends StatelessWidget {
  const GradientLine({
    Key? key,
    this.height = 6,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(color: WeTrekColors.blue4),
          ),
          Expanded(
            flex: 1,
            child: Container(color: WeTrekColors.blue3),
          ),
          Expanded(
            flex: 1,
            child: Container(color: WeTrekColors.blue2),
          ),
          Expanded(
            flex: 1,
            child: Container(color: WeTrekColors.blue1),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? child;
  final VoidCallback? onPressed;
  final IconData rightIcon;
  final Color color;
  final Color fontColor;
  final SearchBloc? bloc;
  @override
  final Size preferredSize;
  final bool hasSearch;
  MyAppBar({
    required this.title,
    this.child,
    this.onPressed,
    this.rightIcon = Icons.filter_list,
    this.color = Colors.white,
    this.fontColor = const Color(0xff454F63),
    this.hasSearch = false,
    this.bloc,
  }) : preferredSize = Size.fromHeight(child == null ? 136.0 : 176);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  late TextEditingController _controller;
  late final SearchBloc? searchBloc;
  bool isSearching = false;
  @override
  initState() {
    if (widget.hasSearch) {
      _controller = TextEditingController();
      searchBloc = context.read<SearchBloc>();
    }
    super.initState();
  }

  onBackPressed() {
    searchBloc?.add(SearchFetched());
    setState(() {
      isSearching = false;
    });
  }

  onSearchPressed() {
    setState(() {
      isSearching = true;
    });
  }

  search(String s) {
    log('searching..' + s);
    searchBloc?.add(SearchFetched(query: s));
  }

  List<Widget> whatType(Size size) {
    if (isSearching) {
      return [
        Container(
          padding: EdgeInsets.only(left: 24, top: 56, right: 24),
          // height: 26,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onBackPressed,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.transparent,
                  child: Icon(Icons.arrow_back, color: widget.fontColor),
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 26,
                width: size.width - 150,
                child: TextField(
                  controller: _controller,
                  onChanged: search,
                  style: TextStyle(color: Color(0xff454F63)),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffF4F4F6),
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  search(_controller.value.text);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.transparent,
                  child: Icon(Icons.search, color: widget.fontColor),
                ),
              )
            ],
          ),
        )
      ];
    }
    return [
      Container(
        padding: EdgeInsets.only(left: 24, top: 46, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBarNavigation(
              fontColor: widget.fontColor,
              onPressed: widget.hasSearch ? onSearchPressed : widget.onPressed,
              rightIcon: widget.rightIcon,
            ),
            SizedBox(height: 14),
            Container(
              width: size.width - 48,
              height: 40,
              child: Text(
                widget.title,
                style: TextStyles.title.copyWith(
                  color: widget.fontColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 19),
      widget.child ?? Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: isSearching ? 116 : 198,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            color: Color(0xff2a455B63),
            blurRadius: 16,
          )
        ],
        color: widget.color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: whatType(size),
      ),
    );
  }
}

class ReviewBar extends StatelessWidget {
  ReviewBar({
    required this.max,
    required this.num,
  });
  final int max;
  final int num;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (var i = 0; i < num; i++)
            Icon(Icons.star, color: Color(0xffFFB900)),
          for (var i = 0; i < max - num; i++)
            Icon(Icons.star, color: Color(0x5affffff)),
        ],
      ),
    );
  }
}

class MyAppBarNavigation extends StatelessWidget
// implements PreferredSizeWidget
{
  const MyAppBarNavigation({
    Key? key,
    this.onPressed,
    this.onBackPressed,
    this.rightIcon,
    this.fontColor = const Color(0xff454F63),
  })
  //  : preferredSize = const Size.fromHeight(16.0)
  ;

  final Color fontColor;
  final VoidCallback? onPressed;
  final VoidCallback? onBackPressed;
  final IconData? rightIcon;

  // @override
  // final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => onBackPressed == null
                ? Navigator.pop(context)
                : onBackPressed!(),
            child: Container(
              width: 30,
              height: 30,
              color: Colors.transparent,
              child: Icon(Icons.arrow_back, color: fontColor),
            ),
          ),
          rightIcon != null
              ? GestureDetector(
                  onTap: onPressed,
                  child: Icon(rightIcon, color: fontColor),
                )
              : Container(),
        ],
      ),
    );
  }
}

class SingleTab extends StatelessWidget {
  SingleTab(this.title, {required this.active});
  final String title;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 16.0, color: Color(0xffF4F4F6)),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xff454F63),
          height: 17 / 13,
        ),
      ),
    );
  }
}

class MovementDrawing extends StatelessWidget {
  MovementDrawing({required this.width, required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CustomPaint(
        foregroundPainter: MovementPainter(),
      ),
    );
  }
}

class BlueDashGradientDecoration extends Decoration {
  final BoxPainter _painter;

  BlueDashGradientDecoration({required double height})
      : _painter = _BlueGradientPainter(height);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _BlueGradientPainter extends BoxPainter {
  final Paint _paint;
  final double height;
  _BlueGradientPainter(this.height)
      : _paint = Paint()
          ..color = WeTrekColors.blue4
          ..strokeWidth = height
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    _paint.color = WeTrekColors.blue4;
    canvas.drawLine(
      offset + Offset(0, cfg.size!.height),
      offset + Offset(cfg.size!.width / 4, cfg.size!.height),
      _paint,
    );
    _paint.color = WeTrekColors.blue3;
    canvas.drawLine(
      offset + Offset(cfg.size!.width / 4, cfg.size!.height),
      offset + Offset(cfg.size!.width / 2, cfg.size!.height),
      _paint,
    );
    _paint.color = WeTrekColors.blue2;
    canvas.drawLine(
      offset + Offset(cfg.size!.width / 2, cfg.size!.height),
      offset + Offset(cfg.size!.width / 4 * 3, cfg.size!.height),
      _paint,
    );
    _paint.color = WeTrekColors.blue1;
    canvas.drawLine(
      offset + Offset(cfg.size!.width / 4 * 3, cfg.size!.height),
      offset + Offset(cfg.size!.width, cfg.size!.height),
      _paint,
    );
  }
}

class BottomSheetDecoration extends Decoration {
  final BoxPainter _painter;

  BottomSheetDecoration() : _painter = _BottomSheetDecorationPainter();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _BottomSheetDecorationPainter extends BoxPainter {
  final Paint _paint;
  // final double height;
  _BottomSheetDecorationPainter()
      : _paint = Paint()
          ..color = WeTrekColors.blue4
          ..strokeWidth = 12
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    _paint.color = WeTrekColors.blue4;
    canvas.drawLine(
      offset + Offset(0, 0),
      offset + Offset(cfg.size!.width / 4, 0),
      _paint,
    );
    _paint.color = WeTrekColors.blue3;
    canvas.drawLine(
      offset + Offset(cfg.size!.width / 4, 0),
      offset + Offset(cfg.size!.width / 2, 0),
      _paint,
    );
    _paint.color = WeTrekColors.blue2;
    canvas.drawLine(
      offset + Offset(cfg.size!.width / 2, 0),
      offset + Offset(cfg.size!.width / 4 * 3, 0),
      _paint,
    );
    _paint.color = WeTrekColors.blue1;
    canvas.drawLine(
      offset + Offset(cfg.size!.width / 4 * 3, 0),
      offset + Offset(cfg.size!.width, 0),
      _paint,
    );
  }
}

class MovementPainter extends CustomPainter {
  MovementPainter({this.horizontal = false});
  final bool horizontal;
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final bigCirclePaint = Paint()..color = Color(0xff78849E);
    final smallCirclePaint = Paint()..color = Color(0x4a78849E);

    if (horizontal) {
      canvas.drawCircle(Offset(4, 0), 4, bigCirclePaint);

      double startX = 17;
      while (startX < size.width - 17) {
        canvas.drawCircle(Offset(startX, 0), 1.5, smallCirclePaint);
        startX += 9;
      }

      canvas.drawCircle(Offset(size.width - 4, 0), 4, bigCirclePaint);
    } else {
      canvas.drawCircle(Offset(0, 4), 4, bigCirclePaint);

      double startY = 17;
      while (startY < size.height - 17) {
        canvas.drawCircle(Offset(0, startY), 1.5, smallCirclePaint);
        startY += 9;
      }

      canvas.drawCircle(Offset(0, size.height - 4), 4, bigCirclePaint);
    }
  }
}

class Popup extends StatelessWidget {
  Popup({
    required this.title,
    required this.body,
    this.buttonsWidget,
  });
  final String title;
  final String body;
  final Widget? buttonsWidget;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white60,
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width - 48,
//        height: 200,
          constraints: BoxConstraints(
            minHeight: 200,
            maxHeight: 330,
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 24,
          ),
          decoration: BoxDecoration(
            color: Color(0xff2A2E43),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyles.large),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  body,
                  style: TextStyle(color: Color(0xaeffffff), height: 22 / 14),
                ),
              ),
              SizedBox(height: 23),
              Container(
                child: buttonsWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white60,
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width - 48,
//        height: 200,
          constraints: BoxConstraints(
            minHeight: 200,
            maxHeight: 330,
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 24,
          ),
          decoration: BoxDecoration(
            color: Color(0xff2A2E43),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class ConfirmPopup extends StatelessWidget {
  ConfirmPopup({
    required this.title,
    required this.body,
  });
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Popup(
      title: title,
      body: body,
      buttonsWidget: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(112),
                color: Color(0xffC840E9),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 24),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(112),
              color: Color(0xff3ACCE1),
            ),
            child: Icon(Icons.done, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class DialogPopup extends StatelessWidget {
  DialogPopup({
    required this.title,
    required this.body,
    this.okText = 'OK',
    this.cancelText = 'CANCEL',
    this.okFunction,
  });
  final String title;
  final String body;
  final String okText;
  final String cancelText;
  final VoidCallback? okFunction;
  @override
  Widget build(BuildContext context) {
    return Popup(
      title: title,
      body: body,
      buttonsWidget: Column(
        children: [
          MyButton(
            okText,
            onTap: okFunction,
            color: Color(0xff3ACCE1),
          ),
          MyButton(
            cancelText,
            onTap: () {
              Navigator.pop(context);
            },
            color: Color(0xff454F63),
          ),
        ],
      ),
    );
  }
}

class ErrorPopup extends StatelessWidget {
  ErrorPopup({
    required this.title,
    required this.body,
    this.text = 'OK',
//    this.callbackFunction,
  });
  final String title;
  final String body;
  final String text;
//  final VoidCallback? callbackFunction;
  @override
  Widget build(BuildContext context) {
    return Popup(
      title: title,
      body: body,
      buttonsWidget: MyButton(
        text,
        onTap: () {
          Navigator.pop(context);
        },
        color: Color(0xff3ACCE1),
      ),
    );
  }
}

class FollowButton extends StatefulWidget {
  FollowButton(this.user);
  final User user;

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowing;
  @override
  initState() {
    List<int> followers =
        BlocProvider.of<AuthenticationBloc>(context).state.user?.following ??
            [];
    isFollowing = followers.contains(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isFollowing = !isFollowing;
        });
        String token =
            RepositoryProvider.of<AuthenticationRepository>(context).token!;
        UserRepository userRepository = UserRepository(token);
        bool isF = await userRepository.follow(widget.user);
        setState(() {
          isFollowing = isF;
        });
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isFollowing ? Color(0xffE9EBEF) : Color(0xff665EFF),
        ),
        child: Text(
          isFollowing ? 'UNFOLLOW' : 'FOLLOW',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isFollowing ? Color(0xff78849E) : Colors.white,
            height: 17 / 13,
          ),
        ),
      ),
    );
  }
}

class TutorialPanel extends StatelessWidget {
  TutorialPanel({
    required this.title,
    required this.body,
  });
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: Color(0xff2A2E43),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyles.large),
          SizedBox(height: 15),
          Text(
            body,
            style: TextStyle(color: Color(0xaeffffff), height: 22 / 14),
          ),
          SizedBox(height: 23),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DottedTabBar(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff454F63),
                        ),
                        child: Icon(Icons.arrow_back,
                            color: Colors.white, size: 24),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff3ACCE1),
                        ),
                        child: Icon(Icons.arrow_forward,
                            color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverlayPlacedCard extends StatelessWidget {
  OverlayPlacedCard({
    required this.title,
    required this.subTitle,
    this.coverImage,
    this.active = false,
  });

  final String title;
  final String subTitle;
  final String? coverImage;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      height: 200,
      margin: EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              'images/sushi.jpg',
              fit: BoxFit.cover,
              width: 152,
              height: 200,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x002A2E43),
                    Color(0x8408090D),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(subTitle, style: TextStyles.minor),
                        SizedBox(width: 2),
                        Icon(Icons.star, color: Color(0x89ffffff), size: 16),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlacedCard extends StatelessWidget {
  PlacedCard({
    required this.place,
    this.active = false,
  });

  final Address place;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final String _mapsKey = 'AIzaSyAXYH6jQZSQ6vr6WWgTVpx_Bph2TzEYOY8';
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: active ? 200 : 50,
          width: 152,
          child: Stack(
            children: [
              // Image.network(
              //   // this.coverImage,
              // "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${place.reference}&key=$_mapsKey",
              //   height: active ? 200 : 172,
              //   fit: BoxFit.cover,
              // ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 152,
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 12,
                    bottom: 6,
                  ),
                  color: active ? WeTrekColors.blue1 : Color(0xff353A50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Opacity(
                        opacity: 0.56,
                        child: Text(place.description, style: TextStyles.minor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyInput extends StatelessWidget {
  MyInput({
    this.controller,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.key,
    this.obscureText = false,
    this.isDark = false,
    this.enabled = true,
    this.label,
    this.prefixIcon,
  });
  final bool isDark;
  final bool enabled;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final String? label;
  final Icon? prefixIcon;
  final bool obscureText;
  final Key? key;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(12),
//        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14455B63),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: TextField(
        key: key,
        onChanged: onChanged,
        controller: controller,
        style: isDark ? TextStyles.normal : TextStyles.input,
        obscureText: obscureText,
        enabled: enabled,
        decoration: InputDecoration(
          fillColor: isDark ? Color(0xff454F63) : Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xffFF4F9A), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xffFF4F9A), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xff3ACCE1), width: 2),
          ),
          hintText: hintText,
          errorText: errorText,
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xff959DAD),
            fontSize: 11,
//            height: 15/11,
          ),
          prefixIcon: prefixIcon,
          hintStyle: TextStyle(
            color: isDark ? Color(0xff959DAD) : Color(0x9078849E),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  const MyBullet();
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 3.0,
      width: 3.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({required this.text, this.bullet = const MyBullet()});
  final Widget bullet;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bullet,
          SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: TextStyles.terms,
            ),
          ),
        ],
      ),
    );
  }
}

class MyTimePicker extends StatefulWidget {
  MyTimePicker(this.controller);
  final TextEditingController controller;

  @override
  _MyTimePickerState createState() => _MyTimePickerState();
}

class _MyTimePickerState extends State<MyTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  @override
  initState() {
    _dateController = TextEditingController(text: _dateFormat());
    _timeController = TextEditingController(text: _timeFormat());
    widget.controller.text = _formatLaravelDateTime();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = _dateFormat();
        widget.controller.text = _formatLaravelDateTime();
      });
  }

  String _dateFormat() {
    return "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
  }

  String _timeFormat() {
    return "${selectedTime.hour}:${selectedTime.minute}";
  }

  String _formatLaravelDateTime() {
    return "${_dateFormat()} ${_timeFormat()}";
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _timeController.text = _timeFormat();
        widget.controller.text = _formatLaravelDateTime();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: MyInput(
              label: 'Select Date',
              controller: _dateController,
              isDark: true,
              prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
              hintText: 'Select Date',
              enabled: false,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _selectTime(context);
            },
            child: MyInput(
              controller: _timeController,
              isDark: true,
              label: 'Select Time',
              prefixIcon: Icon(Icons.timer, color: Colors.white),
              hintText: 'Select Time',
              enabled: false,
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryItem extends StatelessWidget {
  final IconData icon;
  final subTitle;
  final String title;
  final Widget? child;
  const HistoryItem({
    Key? key,
    required this.icon,
    required this.subTitle,
    required this.title,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: WeTrekColors.blue4,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                Container(
                  width: 2,
                  height: 100,
                  color: Color(0x20959DAD),
                )
              ],
            ),
          ),
          SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: TextStyles.darkMinor,
              ),
              Text(
                title,
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 11),
              child ?? Container(),
              SizedBox(height: 53),
            ],
          )
        ],
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({Key? key, required this.onClick}) : super(key: key);
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        child: Column(
          children: [
            Text('Failed to fetch items'),
            Icon(Icons.refresh),
          ],
        ),
      ),
    );
  }
}
