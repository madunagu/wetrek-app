import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';

class MyButton extends StatelessWidget {
  MyButton(this.text, {this.onTap, this.color = const Color(0xff3ACCE1)});
  final String text;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 44,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 17 / 13,
          ),
        ),
      ),
    );
  }
}

class GradientLine extends StatelessWidget {
  const GradientLine({
    Key key,
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Function onPressed;
  final IconData rightIcon;
  final Color color;
  final Color fontColor;
  @override
  final Size preferredSize;
  MyAppBar({
    @required this.title,
    this.child,
    this.onPressed,
    this.rightIcon = Icons.filter_list,
    this.color = Colors.white,
    this.fontColor = const Color(0xff454F63),
  }) : preferredSize = Size.fromHeight(child == null ? 136.0 : 176);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            color: Color(0xff2a455B63),
            blurRadius: 16,
          )
        ],
        color: color,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 24, top: 46, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back, color: fontColor),
                      ),
                      GestureDetector(
                        onTap: onPressed,
                        child: Icon(rightIcon, color: fontColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  title,
                  style: TextStyles.title.copyWith(
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 19),
          child ?? Container(),
        ],
      ),
    );
  }
}

class SingleTab extends StatelessWidget {
  SingleTab(this.title, {this.active});
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
  MovementDrawing({@required this.width, @required this.height});
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

  BlueDashGradientDecoration({@required double height})
      : _painter = _BlueGradientPainter(height);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
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
      offset + Offset(0, cfg.size.height),
      offset + Offset(cfg.size.width / 4, cfg.size.height),
      _paint,
    );
    _paint.color = WeTrekColors.blue3;
    canvas.drawLine(
      offset + Offset(cfg.size.width / 4, cfg.size.height),
      offset + Offset(cfg.size.width / 2, cfg.size.height),
      _paint,
    );
    _paint.color = WeTrekColors.blue2;
    canvas.drawLine(
      offset + Offset(cfg.size.width / 2, cfg.size.height),
      offset + Offset(cfg.size.width / 4 * 3, cfg.size.height),
      _paint,
    );
    _paint.color = WeTrekColors.blue1;
    canvas.drawLine(
      offset + Offset(cfg.size.width / 4 * 3, cfg.size.height),
      offset + Offset(cfg.size.width, cfg.size.height),
      _paint,
    );
  }
}

class MovementPainter extends CustomPainter {
  MovementPainter({this.color});
  final Color color;
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final bigCirclePaint = Paint()..color = Color(0xff78849E);
    final smallCirclePaint = Paint()..color = Color(0x4a78849E);

    canvas.drawCircle(Offset(0, 4), 4, bigCirclePaint);

    double startY = 17;
    while (startY < size.height - 17) {
      canvas.drawCircle(Offset(0, startY), 1.5, smallCirclePaint);
      startY += 9;
    }

    canvas.drawCircle(Offset(0, size.height - 4), 4, bigCirclePaint);
  }
}

class NotificationPopup extends StatelessWidget {
  NotificationPopup({
    @required this.title,
    @required this.body,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(112),
                    color: Color(0xffC840E9),
                  ),
                  child: Icon(Icons.cancel, color: Colors.white, size: 24),
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
          ),
        ],
      ),
    );
  }
}

class PlacedCard extends StatelessWidget {
  PlacedCard({
    @required this.title,
    @required this.subTitle,
    this.coverImage,
    this.active = false,
  });

  final String title;
  final String subTitle;
  final String coverImage;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: active ? 200 : 50,
        width: 152,
        child: Stack(
          children: [
            Image.asset(
              'images/sushi.jpg',
              height: active ? 200 : 172,
              fit: BoxFit.cover,
            ),
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
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Opacity(
                      opacity: 0.56,
                      child: Text(subTitle, style: TextStyles.minor),
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
