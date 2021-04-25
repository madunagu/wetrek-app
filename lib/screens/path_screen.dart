import 'package:flutter/material.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class TransportPathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 42),
          child: Column(
            children: [
              LocationPairCard(),
              SizedBox(height: 16),
              TransportChips(),
              SizedBox(height: 21),
              DestinationPath(),
            ],
          ),
        ),
      ),
    );
  }
}

class TransportChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WeTrekColors.darkPurple3,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.directions_bus, color: Colors.white, size: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0xffC840E9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('505',
                style: TextStyles.minor.copyWith(color: Colors.white)),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0x30ffffff),
            size: 14,
          ),
          Icon(
            Icons.directions_bus,
            color: Colors.white,
            size: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0xff5773FF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('505',
                style: TextStyles.minor.copyWith(color: Colors.white)),
          ),
          Spacer(),
          Text('42min', style: TextStyles.minor.copyWith(color: Colors.white))
        ],
      ),
    );
  }
}

class DestinationPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 84,
                alignment: Alignment.topCenter,
                child: Icon(Icons.directions_walk, color: Color(0xff78849E)),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: 84,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_bus, color: Color(0xff5773FF)),
                        Text('505')
                      ],
                    ),
                    Text('at 1:09 pm'),
                    Text('at 1:16pm'),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: 84,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_bus, color: Color(0xff5773FF)),
                        Text('505')
                      ],
                    ),
                    Text('at 1:09 pm'),
                    Text('at 1:16pm'),
                  ],
                ),
              ),
              Container(
                height: 84,
                alignment: Alignment.topCenter,
                child: Icon(Icons.directions_walk, color: Color(0xff78849E)),
              ),
              Container(
                height: 84,
                alignment: Alignment.topCenter,
                child: Icon(Icons.location_on, color: Color(0xff78849E)),
              ),
            ],
          ),
          MovementDrawingForDestination(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fresh Market Centre', style: TextStyles.darkNormal),
                    Text('Walk 400m(1min)', style: TextStyles.darkMinor),
                  ],
                ),
              ),
              Container(
                height: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fresh Market Centre', style: TextStyles.darkNormal),
                    Text('Walk 400m(1min)', style: TextStyles.darkMinor),
                  ],
                ),
              ),
              Container(
                height: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fresh Market Centre', style: TextStyles.darkNormal),
                    Text('Walk 400m(1min)', style: TextStyles.darkMinor),
                  ],
                ),
              ),
              Container(
                height: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fresh Market Centre', style: TextStyles.darkNormal),
                    Text('Walk 400m(1min)', style: TextStyles.darkMinor),
                  ],
                ),
              ),
              Container(
                height: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fresh Market Centre', style: TextStyles.darkNormal),
                    Text('Walk 400m(1min)', style: TextStyles.darkMinor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovementDrawingForDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      padding: EdgeInsets.symmetric(horizontal: 42),
      height: 346,
      child: CustomPaint(
        foregroundPainter: MovementPainter(),
      ),
    );
  }
}
