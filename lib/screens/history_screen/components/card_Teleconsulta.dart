import 'package:applaluz/screens/medic_menu/list_medic_screen.dart';
import 'package:applaluz/screens/history_screen/history_teleconsultation.dart';
import 'package:applaluz/screens/payment_screen/payment_screen.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:applaluz/constants.dart';
import 'dart:math';

class HistoryMenuTele extends StatelessWidget {
  
  HistoryMenuTele({
    Key key,
    this.controller,
  })  :

        // Each animation defined here transforms its value during the subset
        // of the controller's duration defined by the animation's interval.
        // For example the opacity animation transforms its value during
        // the first 10% of the controller's duration.

        height = Tween<double>(begin: 150, end: 250.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        itemHeight = Tween<double>(begin: 0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> height;
  final Animation<double> itemHeight;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      height: height.value,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: new ExactAssetImage('assets/images/backinfoteleconsulta.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Teleconsultas",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Positioned(
              bottom: 0.0,
              top: -10.0,
              left: 200,
              child: Transform.rotate(
                angle: -pi / -9.0,
                child: Icon(Icons.video_call, size: 200.0, color: Colors.grey[200],),//getIcon(category.icon, 200.0, Colors.grey[200]),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class StaggeredCardCard extends StatefulWidget {
  //final Category category;

  const StaggeredCardCard({Key key}) : super(key: key);

  @override
  _StaggeredCardCardState createState() => _StaggeredCardCardState();
}

class _StaggeredCardCardState extends State<StaggeredCardCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  bool isActive = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
       Navigator.pushNamed(context, '/history_teleconsultation');
      },
      child: HistoryMenuTele(
        controller: _controller.view,
        //category: widget.category,
      ),
    );
  }
}

