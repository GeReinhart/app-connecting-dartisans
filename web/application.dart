library connecting_dartisans.app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/application.dart';
import 'pages/about.dart';
import 'pages/details.dart';
import 'pages/home.dart';
import 'pages/list.dart';
import 'pages/profile.dart';
import 'pages/map.dart';
import 'pages/register.dart';
import 'pages/search.dart';

void main() {
  initPolymer().run(() {
    Polymer.onReady.then((_) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((LogRecord rec) {
        print('${rec.level.name}: ${rec.time}: ${rec.message}');
      });

      ConnectingDartisansApplication application = querySelector("#application") as ConnectingDartisansApplication;

      ApplicationEventBus applicationEventBus = new ApplicationEventBus();
      PageKeyUrlConverter pageKeyUrlConverter = new PageKeyUrlConverter();
      Router router = new Router(pageKeyUrlConverter);
      ApplicationEventLogger applicationEventLogger = new ApplicationEventLogger();

      Authenticator authenticator = new GoogleAuthenticator(clientId());
      LoginFlow loginFlow = new LoginFlow(authenticator, new UserChecker());

      loginFlow.setApplicationEventBus(applicationEventBus);
      authenticator.setApplicationEventBus(applicationEventBus);
      router.setApplicationEventBus(applicationEventBus);
      application.setApplicationEventBus(applicationEventBus);
      applicationEventLogger.setApplicationEventBus(applicationEventBus);

      router.init();
      application.init();
    });
  });
}

String clientId() {
  if (window.location.hostname == "localhost") {
    return "765376678220-21161f3h7quqp1l57mh96sopdjndhntl.apps.googleusercontent.com";
  }
  if (window.location.hostname == "qa-connecting-dartisans.herokuapp.com") {
    return "765376678220-650s0gq93ap8db8uk0rkg19l8265npcq.apps.googleusercontent.com";
  }

  return "";
}

@CustomTag('connecting-dartisans')
class ConnectingDartisansApplication extends Application {
  static final Color DART_BLUE_ORANGE = new Color(
      "#013552", "#005B8C", "#0082C8", "#59ACD9", "#99C6DE", "#EF4716", "#FF7415", "#FFAB15", "#FFC866", "#FFDEA3");

  static final Color DART_LIGHT_BLUE_ORANGE = new Color(
      "#005B8C", "#0082C8", "#59ACD9", "#99C6DE", "#B6CEDB", "#FF7415", "#FFAB15", "#FFC866", "#FFDEA3", "#FFEDCC");

  static final Color GREY_BLUE_GREEN = new Color(
      "#40494D", "#6A777D", "#ABB3B8", "#C3C7C9", "#E3E3E3", "#4E5444", "#79826B", "#ACB89A", "#CBD1C0", "#DEE0DA");

  final Logger log = new Logger('ConnectingDartisansApplication');

  Color mainColor = DART_BLUE_ORANGE;

  ConnectingDartisansApplication.created() : super.created() {}
  @override
  void ready() {
    super.ready();

    _setAttributes();
  }

  void _setAttributes() {
    addPage(new Element.tag('page-home'));
    addPage(new Element.tag('page-search'));
    addPage(new Element.tag('page-map'));
    addPage(new Element.tag('page-list'));
    addPage(new Element.tag('page-profile'));
    addPage(new Element.tag('page-register'));
    addPage(new Element.tag('page-about'));
    addPage(new Element.tag('page-details'));

    List<ButtonModel> topToolbar = new List<ButtonModel>();
    topToolbar.add(new ButtonModel(
        label: "Home",
        image: new Image(mainImageUrl: "images/button/back57.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageHome.NAME)));
    topToolbar.add(new ButtonModel(
        label: "Search",
        image: new Image(mainImageUrl: "images/button/search54.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageSearch.NAME)));
    topToolbar.add(new ButtonModel(
        label: "Map",
        image: new Image(mainImageUrl: "images/button/map32.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageMap.NAME)));
    topToolbar.add(new ButtonModel(
        label: "List",
        image: new Image(mainImageUrl: "images/button/list23.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageList.NAME)));
    ToolbarModel topToolbarModel =
        new ToolbarModel(buttons: topToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);
    addToolbar(topToolbarModel);

    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add(new ButtonModel(
        label: "Login",
        image: new Image(mainImageUrl: "images/button/login.png"),
        type: ButtonType.LOGIN_PROFILE,
        targetPageKey: new PageKey(name: PageProfile.NAME)));
    bottomToolbar.add(new ButtonModel(
        label: "About",
        image: new Image(mainImageUrl: "images/button/info24.png"),
        type: ButtonType.PAGE_LAUNCHER,
        targetPageKey: new PageKey(name: PageAbout.NAME)));
    ToolbarModel bottomToolbarModel =
        new ToolbarModel(buttons: bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);
    addToolbar(bottomToolbarModel);
  }
}
