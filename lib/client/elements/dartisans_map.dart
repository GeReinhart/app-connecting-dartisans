// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisans_map;

import "dart:html";
import "dart:async";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:google_maps/google_maps.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';

class DartisansMap extends Object with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisansMap');
  final LatLng defaultPosition = new LatLng(45.15723059999999, 5.730393700000049);
  final LatLngBounds defaultBounds = new LatLngBounds(
      new LatLng(-64.85571932665043, 169.94338350712894), new LatLng(74.18969003290712, -157.91062039912103));
  DivElement _map;
  GMap _googleMap;
  Dartisans _dartisans;
  Map<String,Marker> _markers = new Map<String,Marker>();
  bool hasBeenShown = false;

  
  DartisansMap(this._map) {
    this._map.style.visibility = null;
    init();
  }

  void init() {
    final mapOptions = new MapOptions()
      ..center = _adaptPosition(defaultPosition)
      ..zoom = 6
      ..mapTypeId = MapTypeId.ROADMAP
      ..streetViewControl = false;

    _googleMap = new GMap(_map, mapOptions);
    geoLocation();

    new Timer(new Duration(seconds: 1), _checkBounds);
  }

  LatLng _adaptPosition(LatLng position) {
    return new LatLng(position.lat + 3, position.lng - 12);
  }

  Bounds _lastBounds = null;
  void _checkBounds() {
    event.trigger(_googleMap, 'resize', []);
    if (_googleMap.bounds == null) {
      return;
    }

    Bounds bounds = new Bounds(_googleMap.bounds.northEast.lat, _googleMap.bounds.northEast.lng,
        _googleMap.bounds.southWest.lat, _googleMap.bounds.southWest.lng);
    if (_lastBounds == null || _lastBounds != null && _lastBounds != bounds) {
      _lastBounds = bounds;
      if (!_lastBounds.isEmpty && hasBeenShown) {
        fireApplicationEvent(new DartisansApplicationEvent.mapChange(this, bounds));
      }
    }
    new Timer(new Duration(seconds: 1), _checkBounds);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent applicationEvent) {
    if (applicationEvent.isViewPortChange) {
      this._map
        ..style.height = "${applicationEvent.viewPort.windowHeight}px"
        ..style.width = "${applicationEvent.viewPort.windowWidth}px";
      event.trigger(_googleMap, 'resize', []);
    }
    if (applicationEvent is DartisansApplicationEvent) {
      if (applicationEvent.isSearchSuccess || applicationEvent.isMapChangeDartisans) {
        this._dartisans = applicationEvent.dartisans;
        _updateMarkers();
      }
      if (applicationEvent.isSaveDartisanSuccess) {
        this._dartisans.put(applicationEvent.dartisan);
        _updateMarkers();
      }
    }
  }

  void _updateMarkers() {
    
    Iterator keyIterator = _markers.keys.iterator ;
    List<String> markerToRemove = new List<String>();
    while(keyIterator.moveNext()){
      if (_dartisans.dartisans[keyIterator.current] == null){
        Marker currentMarker = _markers[keyIterator.current];
        currentMarker.map = null;
        markerToRemove.add(keyIterator.current);
      }
    }
    markerToRemove.forEach((m)=> _markers.remove(m));

    _dartisans.dartisanList.forEach((dartisan) {
      if (!_markers.containsKey(dartisan.openId)){
          LatLng position = new LatLng(dartisan.locationLat, dartisan.locationLng);
    
          Icon image = new Icon()
            ..url = dartisan.avatarUrl.replaceAll("sz=150", "sz=40")
            ..size = new Size(40, 40)
            ..origin = new Point(0, 0)
            ..anchor = new Point(20, 20);
    
          Marker marker = new Marker(new MarkerOptions()
            ..position = position
            ..icon = image
            ..map = _googleMap
            ..title = dartisan.displayName);
          marker.onClick.listen((_) {
            fireApplicationEvent(new DartisansApplicationEvent.callDetails(this, dartisan.openId));
          });
          _markers[dartisan.openId]= marker;
      }
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
    hasBeenShown = true;
  }

  @override
  void hide() {
    _map.style.display = "hidden";
  }

  void geoLocation() {
    if (window.navigator.geolocation != null) {
      window.navigator.geolocation.getCurrentPosition().then((position) {
        _googleMap.center = _adaptPosition(new LatLng(position.coords.latitude, position.coords.longitude));
      }, onError: (error) {
        _handleNoGeolocation();
      });
    } else {
      // Browser doesn't support Geolocation
      _handleNoGeolocation();
    }
  }

  void panToDefaultPosition() {
    _googleMap.center = _adaptPosition(defaultPosition);
  }

  void _handleNoGeolocation() {
    panToDefaultPosition();
  }
}
