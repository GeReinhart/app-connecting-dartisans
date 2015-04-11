library connecting_dartisans.pages.map;

import "dart:async";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/client/elements/layout.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';
import 'package:connecting_dartisans/client/elements/dartisans_map.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';


@CustomTag('page-map')
class PageMap extends Page with Showable {
  static final String NAME = "map";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;
  DartisansMap map;
  Layout layout;
  bool _hasBeenShown = false;
  PageMap.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    map = new DartisansMap($["map"]);

    LayoutModel layoutModel = new LayoutModel(color: Color.WHITE);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);

    map.panToDefaultPosition();
  }

  @override
  void show() {
    super.show();
    map.show();
    if (!_hasBeenShown) {
      new Timer(new Duration(seconds: 2), () => toastMessage("Dartisans will be filtered also on their location"));
      ;
    }

    _hasBeenShown = true;
  }

  @override
  void hide() {
    super.hide();
    map.hide();
  }

  ApplicationEventBus _eventBus;
  @override
  void setApplicationEventBus(ApplicationEventBus value) {
    super.setApplicationEventBus(value);
    _eventBus = value;
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (_eventBus == null) {
      map.recieveApplicationEvent(event);
    } else {
      map.setApplicationEventBus(_eventBus);
      _eventBus = null;
    }

    if (event is DartisansApplicationEvent) {
      if (event.isSaveDartisanSuccess) {
        toastMessage("Profile saved", color: Color.BLUE_0082C8);
      }
    }
  }
}
