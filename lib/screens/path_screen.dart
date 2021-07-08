import 'package:flutter/material.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/direction.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/trek_screen.dart';
import 'package:wetrek/widgets/map_widgets.dart';
import 'package:wetrek/widgets/widgets.dart';

class PathScreen extends StatelessWidget {
  PathScreen({required this.direction});
  final Direction direction;

  static MaterialPageRoute route(direction) {
    return MaterialPageRoute(
      builder: (context) => PathScreen(direction: direction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 42),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x15455B63),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                padding:
                    EdgeInsets.only(left: 20, right: 16, top: 13, bottom: 15),
                child: LocationPairCard(
                  originAddress: direction.routes[0].legs[0].startAddress,
                  destinationAddress: direction.routes[0].legs.last.endAddress,
                ),
              ),
              SizedBox(height: 16),
              TransportChips(direction: direction),
              SizedBox(height: 21),
              DestinationPath(direction: direction),
              SizedBox(height: 16),
              MyButton(
                'RETURN',
                isLarge: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final Map<String, IconData> transportIcons = {
  'TRANSIT': Icons.directions_transit,
  'WALKING': Icons.directions_walk,
  'DRIVING': Icons.directions_car,
  'CYCLING': Icons.directions_bike,
};

class TransportChips extends StatelessWidget {
  TransportChips({required this.direction});
  final Direction direction;
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
          Icon(transportIcons[direction.routes[0].legs[0].steps[0].travelMode],
              color: Colors.white, size: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0xffC840E9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(direction.routes[0].legs[0].steps[0].distance.text,
                style: TextStyles.minor.copyWith(color: Colors.white)),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0x30ffffff),
            size: 14,
          ),
          Icon(
            transportIcons[direction.routes[0].legs[0].steps.last.travelMode],
            color: Colors.white,
            size: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0xff5773FF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(direction.routes[0].legs[0].steps.last.distance.text,
                style: TextStyles.minor.copyWith(color: Colors.white)),
          ),
          Spacer(),
          Text(direction.routes.first.legs.first.duration.text,
              style: TextStyles.minor.copyWith(color: Colors.white))
        ],
      ),
    );
  }
}

class DestinationPath extends StatelessWidget {
  DestinationPath({required this.direction});
  final Direction direction;

  String addressFromInstructions(String htmlInstructions) {
//    int stop = htmlInstructions.indexOf(',');
    int stop = 8;
    return htmlInstructions.substring(3, stop);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            for (var step in direction.routes[0].legs[0].steps)
              Container(
                height: 84,
                alignment: Alignment.topCenter,
                child: Icon(transportIcons[step.travelMode],
                    color: Color(0xff78849E)),
              ),
//            Container(
//              alignment: Alignment.topCenter,
//              height: 84,
//              child: Column(
//                children: [
//                  Row(
//                    children: [
//                      Icon(Icons.directions_bus, color: Color(0xff5773FF)),
//                      Text('505')
//                    ],
//                  ),
//                  Text('at 1:09 pm'),
//                  Text('at 1:16pm'),
//                ],
//              ),
//            )
          ]),
          MovementDrawingForDestination(
              direction.routes[0].legs[0].steps.length),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var step in direction.routes[0].legs[0].steps)
                Container(
                  height: 84,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(addressFromInstructions(step.htmlInstructions),
                          style: TextStyles.darkNormal),
                      Text(
                          "${step.travelMode.toLowerCase()} ${step.distance.text}(${step.duration.text})",
                          style: TextStyles.darkMinor),
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
  MovementDrawingForDestination(this.steps);
  final int steps;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      padding: EdgeInsets.symmetric(horizontal: 42),
      height: 77.0 * steps,
      child: CustomPaint(
        foregroundPainter: MovementPainter(),
      ),
    );
  }
}
