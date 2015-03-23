library connecting_dartisans.pages.home;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';

import '../application.dart';
import 'list.dart';
import 'map.dart';
import 'search.dart';
import 'profile.dart';

@CustomTag('page-home')
class PageHome extends Page with Showable {
  static final String NAME = "home";
  final Logger log = new Logger(NAME);

  Color mainColor = ConnectingDartisansApplication.DART_LIGHT_BLUE_ORANGE.lightColorAsColor;

  Layout layout;
  ImageElement dartLogo;
  ApplicationEventBus _applicationEventBus;

  PageHome.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    dartLogo = $["dartLogo"] as ImageElement;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels
        .add(new ButtonModel(label: "Map", action: map, image: new Image(mainImageUrl: "/images/button/map32.png")));
    buttonModels.add(new ButtonModel(
        label: "Search", action: search, image: new Image(mainImageUrl: "/images/button/search54.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: Color.GREY_858585.lightColorAsColor,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT,
        orientation: Orientation.est);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void moveTo(Position position) {
    super.moveTo(position);
    num dartLogoWidth = position.width / 3 > 400 ? 400 : position.width / 3;
    dartLogo.style.width = "${dartLogoWidth}px";
  }

  @override
  void setApplicationEventBus(ApplicationEventBus value) {
    super.setApplicationEventBus(value);
  }

  map(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageMap.NAME));
  }
  search(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageSearch.NAME));
  }
}
