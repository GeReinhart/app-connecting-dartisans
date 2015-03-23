library connecting_dartisans.pages.map;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:connecting_dartisans/client/elements/dartisans_map.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';

import '../application.dart';

@CustomTag('page-map')
class PageMap extends Page with Showable {
  static final String NAME = "map";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;
  DartisansMap map;
  Layout layout;

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
  }

  @override
  void show() {
    super.show();
    map.show();
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
