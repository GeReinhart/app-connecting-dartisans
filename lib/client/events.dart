// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_client;

enum DartisansEventType {
  SEARCH,
  DETAILS
}

class DartisansApplicationEvent extends ApplicationEvent {
  DartisansEventType dartisansPageType;
  Dartisans dartisans;
  Dartisan dartisan;
  String openId;

  bool dartisansPageTypeIs(DartisansEventType param) => (dartisansPageType != null && dartisansPageType == param);

  DartisansApplicationEvent(Object sender, {this.dartisansPageType, this.dartisans, this.dartisan, this.openId,
      EventStatus status, EventType type, EventError error, User user, String errorDetails, EventPageType pageType,
      PageKey pageKey, ViewPortModel viewPortModel})
      : super(sender,
          status: status,
          type: type,
          error: error,
          user: user,
          errorDetails: errorDetails,
          pageType: pageType,
          pageKey: pageKey,
          viewPortModel: viewPortModel);

  factory DartisansApplicationEvent.callSearch(Object sender) {
    return new DartisansApplicationEvent(sender,
        dartisansPageType: DartisansEventType.SEARCH,
        status: EventStatus.CALL,
        type: EventType.PAGE,
        pageType: EventPageType.CUSTOM);
  }
  bool get isCallSearch => statusIs(EventStatus.CALL) &&
      eventTypeIs(EventType.PAGE) &&
      pageTypeIs(EventPageType.CUSTOM) &&
      dartisansPageTypeIs(DartisansEventType.SEARCH);

  factory DartisansApplicationEvent.searchSuccess(Object sender, Dartisans dartisans) {
    return new DartisansApplicationEvent(sender,
        dartisansPageType: DartisansEventType.SEARCH,
        dartisans: dartisans,
        status: EventStatus.SUCCESS,
        type: EventType.PAGE,
        pageType: EventPageType.CUSTOM);
  }
  bool get isSearchSuccess => statusIs(EventStatus.SUCCESS) &&
      eventTypeIs(EventType.PAGE) &&
      pageTypeIs(EventPageType.CUSTOM) &&
      dartisansPageTypeIs(DartisansEventType.SEARCH) &&
      dartisans != null;

  factory DartisansApplicationEvent.callDetails(Object sender, String openId) {
    return new DartisansApplicationEvent(sender,
        dartisansPageType: DartisansEventType.DETAILS,
        openId: openId,
        status: EventStatus.CALL,
        type: EventType.PAGE,
        pageType: EventPageType.CUSTOM);
  }
  bool get isCallDetails => statusIs(EventStatus.CALL) &&
      eventTypeIs(EventType.PAGE) &&
      pageTypeIs(EventPageType.CUSTOM) &&
      dartisansPageTypeIs(DartisansEventType.DETAILS) &&
      openId != null;

  factory DartisansApplicationEvent.detailsSuccess(Object sender, Dartisan dartisan) {
    List<Parameter> parameters = new List<Parameter>();
    parameters.add(new Parameter("id", dartisan.openId));
    Parameters resources = new Parameters(parameters);
    PageKey pageKey = new PageKey(name: "details", resources: resources);
    return new DartisansApplicationEvent(sender,
        dartisansPageType: DartisansEventType.DETAILS,
        dartisan: dartisan,
        status: EventStatus.SUCCESS,
        type: EventType.PAGE,
        pageType: EventPageType.CUSTOM,
        pageKey: pageKey);
  }
  bool get isDetailsSuccess => statusIs(EventStatus.SUCCESS) &&
      eventTypeIs(EventType.PAGE) &&
      pageTypeIs(EventPageType.CUSTOM) &&
      dartisansPageTypeIs(DartisansEventType.DETAILS) &&
      dartisan != null &&
      pageKey != null;
}
