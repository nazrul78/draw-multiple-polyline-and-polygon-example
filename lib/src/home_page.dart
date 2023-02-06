import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LatLng> polylinePoints = [];
  bool isDrawPolylineEnable = false;

  List<Polyline> polylines = [];
  List<Polyline> polylines1 = [];

  // List<Polyline> polylines1 = [
  //   Polyline(
  //     //points: polylinePoints,
  //     points: [
  //       LatLng(23, 90.750),
  //       LatLng(24, 91.850),
  //     ],
  //     color: Colors.blue,
  //     strokeWidth: 5,
  //   ),
  //   Polyline(
  //     points: [
  //       LatLng(23.72922, 88.270687),
  //       LatLng(23.435092, 88.210665),
  //       LatLng(23.167556, 88.621771),
  //       LatLng(23.457602, 88.731606),
  //     ],
  //     color: Colors.blue,
  //     strokeWidth: 5,
  //   ),
  // ];

  List<LatLng> latlngList1 = [
    // LatLng(24.002549, 90.297772),
    // LatLng(23.960481, 90.51541),
    // LatLng(23.802171, 90.555689),
    // LatLng(23.810781, 90.379916),
    // LatLng(23.600023, 90.344344),
    // LatLng(23.601456, 90.565104)
  ];

  List<LatLng> latlngList2 = [
    // LatLng(23, 91),
    // LatLng(24, 92),
  ];

  void addPolyline({required List<LatLng> points}) {
    log(points.toString());
    polylines = [];
    polylines.add(
      Polyline(
        points: points,
        // points: [
        //   LatLng(23, 90),
        //   LatLng(24, 90),
        // ],
        color: Colors.blue,
        strokeWidth: 5,
      ),
    );

    log(polylines.length.toString());
    log('${polylines.first.points}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Draw multi polyline example',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.tealAccent[300],
        ),
        body: FlutterMap(
          options: MapOptions(
            onTap: (tapPosition, point) async {
              if (isDrawPolylineEnable) {
                polylinePoints.add(point);
                // latlngList1.add(point);
                // log(polylinePoints.toString());
                addPolyline(points: polylinePoints);
                setState(() {});
              }

              // log(latlngList1.toString());
            },
            center: LatLng(23.509364, 90.128928),
            zoom: 9.2,
          ),
          nonRotatedChildren: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 100),
                child: Column(
                  children: [
                    // ============== Used to draw a polyline on map ===========

                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: JustTheTooltip(
                        tailLength: 12.0,
                        offset: 5,
                        preferredDirection: AxisDirection.left,
                        content: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Polilyne',
                            style: TextStyle(
                              fontFamily: 'Manrope Regular',
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: (() async {
                            if (polylines.isNotEmpty) {
                              polylines1.add(polylines.first);
                            }

                            isDrawPolylineEnable = !isDrawPolylineEnable;
                            polylinePoints = [];
                            log(polylinePoints.toString());
                            // latlngList1 = [];
                            setState(() {});
                          }),
                          child: Container(
                              width: 32,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: isDrawPolylineEnable
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              child: Icon(
                                Icons.polyline,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: JustTheTooltip(
                        tailLength: 12.0,
                        offset: 5,
                        preferredDirection: AxisDirection.left,
                        content: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Clear all data',
                            style: TextStyle(
                              fontFamily: 'Manrope Regular',
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: (() {
                            polylines = [];
                            polylines1 = [];

                            setState(() {});

                            log('${polylines.length}');
                            log('${latlngList1.length}');
                          }),
                          child: Container(
                              width: 32,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),

                                color: Colors.grey,
                                // color: homeMapViewC
                                //         .isSelectMapTypeEnable
                                //         .value
                                //     ? hexToColor('#6EA178')
                                //     : hexToColor('#95C08B'),
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            PolylineLayer(
              polylineCulling: false,
              polylines: polylines,
            ),
            PolylineLayer(
              polylineCulling: false,
              polylines: polylines1,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // polylinePoints.clear();
            // polylines.clear();
            log(latlngList2.toString() + '??????????/');
            addPolyline(points: latlngList1);

            // addPolyline(points: latlngList2);

            // polylines.addAll(polylines1);

            //  log('${polylines.first.}');
            log('${polylines.first.points}');
            log('${polylines.first.borderColor}');
            log('${polylines.first.strokeWidth}');
            log('${polylines.length}');

            setState(() {});
          },
          child: Icon(Icons.add),
        ));
  }
}
