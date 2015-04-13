// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_client;

class Controller extends Object with ApplicationEventPassenger {
  final Logger log = new Logger("Controller");

  Controller() {}

  Dartisans dartisans = new Dartisans.empty();
  DateTime lastDartisansRefresh = new DateTime(2000);
  bool waitingForDartisans = false;
  Bounds bounds;
  DartisansSearchForm search;

  void _loadDartisans(DartisansSearchForm search) {
    GetJsonRequest request = new GetJsonRequest("/services/dartisans",
        (Map output) => callSearchSuccess(output, search), (status) => callSearchFailure(status));
    waitingForDartisans = true;
    request.send();
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is DartisansApplicationEvent) {
      if (event.isCallSearch) {
        search = event.search;
        if (!waitingForDartisans &&
            lastDartisansRefresh.isBefore(new DateTime.now().subtract(new Duration(minutes: 2)))) {
          _loadDartisans(search);
        } else {
          fireApplicationEvent(
              new DartisansApplicationEvent.searchSuccess(this, dartisans.newFilteredDartisans(search, bounds)));
        }
      }
      if (event.isMapChange) {
        bounds = event.bounds;
        fireApplicationEvent(
            new DartisansApplicationEvent.mapChangeDartisans(this, dartisans.newFilteredDartisans(search, bounds)));
      }

      if (event.isCallDetails) {
        if (dartisans != null && dartisans.hasDartisanByOpenId(event.openId)) {
          fireApplicationEvent(
              new DartisansApplicationEvent.detailsSuccess(this, dartisans.getDartisanByOpenId(event.openId)));
        }

        GetJsonRequest request = new GetJsonRequest("/services/dartisan/${event.openId}",
            (Map output) => callDetailsSuccess(new Dartisan.loadJSON(output)), (status) => callDetailsFailure(status));
        request.send();
      }
    }

    if (event.isCallSaveUser) {
      PostJsonRequest request = new PostJsonRequest("/services/dartisan/${event.user.openId}",
          (Map output) => saveDartisanSuccess(new Dartisan.loadJSON(output)), (status) => saveDartisanFailure(status));
      request.send(event.user as Dartisan);
      return;
    }

    if (event.isCallPage) {
      if (event.pageKey.name == "list" || event.pageKey.name == "map" || event.pageKey.name == "stats") {
        fireApplicationEvent(new DartisansApplicationEvent.callSearch(this, search));
      }
    }
  }

  void saveDartisanSuccess(Dartisan dartisan) {
    dartisans.put(dartisan);
    fireApplicationEvent(new DartisansApplicationEvent.saveDartisanSuccess(this, dartisan));
  }

  void saveDartisanFailure(num status) {
    // TODO Send failure event
  }

  void callSearchSuccess(Map output, DartisansSearchForm search) {
    Dartisans dartisans = new Dartisans.loadJSON(output);
    this.dartisans = dartisans;
    this.lastDartisansRefresh = new DateTime.now();
    waitingForDartisans = false;
    fireApplicationEvent(
        new DartisansApplicationEvent.searchSuccess(this, dartisans.newFilteredDartisans(search, bounds)));
  }

  void callSearchFailure(num status) {
    waitingForDartisans = false;
    // TODO Send failure event
  }

  void callDetailsSuccess(Dartisan dartisan) {
    dartisans.put(dartisan);
    fireApplicationEvent(new DartisansApplicationEvent.detailsSuccess(this, dartisan));
  }

  void callDetailsFailure(num status) {
    // TODO Send failure event
  }
}
