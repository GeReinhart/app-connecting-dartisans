// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_client;

class Controller extends Object with ApplicationEventPassenger {
  Controller();

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is DartisansApplicationEvent) {
      if (event.isCallSearch) {
        GetJsonRequest request = new GetJsonRequest(
            "/services/dartisans", (Map output) => callSearchSuccess(output), (status) => callSearchFailure(status));
        request.send();
      }

      if (event.isCallDetails) {
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
  }

  void saveDartisanSuccess(User user) {
    // TODO Send sucess event

  }

  void saveDartisanFailure(num status) {
    // TODO Send failure event
  }

  void callSearchSuccess(Map output) {
    Dartisans dartisans = new Dartisans.loadJSON(output);
    fireApplicationEvent(new DartisansApplicationEvent.searchSuccess(this, dartisans));
  }

  void callSearchFailure(num status) {
    // TODO Send failure event
  }

  void callDetailsSuccess(Dartisan dartisan) {
    // TODO Send sucess event

  }

  void callDetailsFailure(num status) {
    // TODO Send failure event
  }
}
