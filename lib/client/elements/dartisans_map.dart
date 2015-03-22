// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisans_map;

import "dart:html";
import "dart:async";
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:google_maps/google_maps.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';

class DartisansMap extends Object with Showable,  ApplicationEventPassenger{
  final LatLng defaultPosition = new LatLng(45.148609248398735, 5.729827880859428);

  DivElement _map;
  GMap _googleMap;
  Dartisans _dartisans;
  List<Marker> _markers = new List<Marker>();
  
  DartisansMap(this._map) {
    this._map.style.visibility = null;
    init();
  }

  void init() {
    final mapOptions = new MapOptions()
      ..center = defaultPosition
      ..zoom = 4
      ..mapTypeId = MapTypeId.ROADMAP
      ..streetViewControl = false;

    _googleMap = new GMap(_map, mapOptions);
    _googleMap.panTo(defaultPosition);
    geoLocation();
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event.isViewPortChange){
      _moveTo(event.viewPort);
    }
    
    if (event is DartisansApplicationEvent) {
      if (event.isSearchSuccess) {
        this._dartisans = event.dartisans;
        _updateMarkers();
      }
    }
    
  }
  
  void _moveTo(ViewPortModel viewPort){
    this._map.style..position = "absolute"
                  ..zIndex = "110"
                  ..top = "0px"
                  ..left = "0px"
                  ..width = "${viewPort.windowWidth}px"
                  ..height = "${viewPort.windowHeight}px"
    ;
  }
  
  void _updateMarkers(){
    
    _markers.forEach((m)=> m.map = null) ;
    _markers.clear();
    
    _dartisans.dartisanList.forEach((dartisan){
      
      LatLng position = new LatLng(dartisan.locationLat, dartisan.locationLng) ;
      
      Icon image = new Icon()
          ..url = dartisan.avatarUrl.replaceAll("sz=150", "sz=60")
          ..size = new Size(60, 60)
          ..origin = new Point(0,0)
          ..anchor = new Point(30, 30);
      
      Marker marker = new Marker(new MarkerOptions()
        ..position = position
        ..icon = image
        ..map = _googleMap
        ..title = dartisan.displayName
      );
      marker.onClick.listen((_){
        fireApplicationEvent(new DartisansApplicationEvent.callDetails(this, dartisan.openId));
      });
      _markers.add(marker);
    });
    
  }
  
  
  @override
  bool isShowed() {
    return _map.style.display != "hidden";
  }

  @override
  void show() {
    _map.style.display = null;
    event.trigger(_googleMap, 'resize', []);
  }

  @override
  void hide() {
    _map.style.display = "hidden";
  }

  void geoLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.getCurrentPosition().then((position) {
        _googleMap.panTo(new LatLng(position.coords.latitude, position.coords.longitude));
      }, onError: (error) {
        _handleNoGeolocation();
      });
    } else {
      // Browser doesn't support Geolocation
      _handleNoGeolocation();
    }
  }

  void _handleNoGeolocation() {
    _googleMap.panTo(defaultPosition);
  }


}
