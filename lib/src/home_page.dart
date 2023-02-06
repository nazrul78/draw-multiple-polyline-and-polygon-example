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

  List<Polyline> tempPolylines = [];
  List<Polyline> polylines = [];

  bool isDrawPolygoneEnable = false;

  List<Polygon> tempPolygins = [];
  List<Polygon> polygins = [];

  void addPolyline({required List<LatLng> points}) {
    log(points.toString());
    tempPolylines = [];
    tempPolylines.add(
      Polyline(
        points: points,
        color: Colors.blue,
        strokeWidth: 5,
      ),
    );

    log(tempPolylines.length.toString());
    log('${tempPolylines.first.points}');
  }

  void addPolygon({required List<LatLng> points}) {
    log(points.toString());
    //tempPolylines = [];
    polygins.add(
      Polygon(
        points: points,
        //color: Colors.blue,
        borderStrokeWidth: 5,
        borderColor: Colors.blue,
      ),
    );

    log(polygins.length.toString());
    log('${polygins.first.points}');
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
                            if (tempPolylines.isNotEmpty) {
                              polylines.add(tempPolylines.first);
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

                    // ============== Used to draw a polygon on map ===========

                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: JustTheTooltip(
                        tailLength: 12.0,
                        offset: 5,
                        preferredDirection: AxisDirection.left,
                        content: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Polygon',
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
                            if (polylinePoints.isNotEmpty) {
                              //polylines.add(tempPolylines.first);
                            }

                            isDrawPolygoneEnable = !isDrawPolygoneEnable;
                            polylinePoints = [];
                            log(polylinePoints.toString());
                            setState(() {});
                          }),
                          child: Container(
                              width: 32,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: isDrawPolygoneEnable
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              child: Icon(
                                Icons.square_outlined,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
// ============== Used to clear all drawing object ===========
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
                            tempPolylines = [];
                            polylines = [];

                            setState(() {});
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
              polylines: tempPolylines,
            ),
            PolylineLayer(
              polylineCulling: false,
              polylines: polylines,
            ),
            //================ Polygon ==============
            PolygonLayer(
              polygonCulling: false,
              polygons: polygins,
            ),
            // PolygonLayer(
            //   polygonCulling: false,
            //   polygons: [
            //     Polygon(
            //       points: [
            //         LatLng(30, 50),
            //         LatLng(40, 60),
            //       ],
            //       //color: Colors.blue,
            //       borderStrokeWidth: 5,
            //       borderColor: Colors.blue,
            //     ),
            //   ],
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ));
  }
}
