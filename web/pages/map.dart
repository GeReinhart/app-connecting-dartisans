library connecting_dartisans.pages.map;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';

import '../application.dart';

@CustomTag('page-map')
class PageMap extends Page with Showable {
  static final String NAME = "map";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;

  Layout layout;

  PageMap.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    LayoutModel layoutModel = new LayoutModel(color: Color.WHITE);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }
}
