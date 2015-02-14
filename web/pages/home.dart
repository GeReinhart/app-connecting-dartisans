library connecting_dartisans.pages.home;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';

import '../application.dart';

@CustomTag('page-home')
class PageHome extends Page with Showable {
  static final String NAME = "home";
  final Logger log = new Logger(NAME);

  Color mainColor = ConnectingDartisansApplication.DART_LIGHT_BLUE_ORANGE.lightColorAsColor;

  Layout layout;
  ImageElement dartLogo;

  PageHome.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    dartLogo = $["dartLogo"] as ImageElement;

    LayoutModel layoutModel = new LayoutModel();
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void moveTo(Position position) {
    super.moveTo(position);
    num dartLogoWidth = position.width / 3 > 400 ? 400 : position.width / 3;
    dartLogo.style.width = "${dartLogoWidth}px";
  }
}
