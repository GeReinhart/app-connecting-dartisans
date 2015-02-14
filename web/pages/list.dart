library connecting_dartisans.pages.list;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';

import '../application.dart';
import 'list.dart';
import 'map.dart';
import 'search.dart';

@CustomTag('page-list')
class PageList extends Page with Showable {
  static final String NAME = "list";
  final Logger log = new Logger(NAME);

  Color mainColor = ConnectingDartisansApplication.DART_LIGHT_BLUE_ORANGE.lightColorAsColor;

  Layout layout;

  PageList.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(new ButtonModel(
        label: "Result on map", action: resultOnMap, image: new Image(mainImageUrl: "/images/button/map32.png")));
    buttonModels.add(new ButtonModel(
        label: "Search", action: search, image: new Image(mainImageUrl: "/images/button/search54.png")));
    buttonModels.add(
        new ButtonModel(label: "Cancel", action: cancel, image: new Image(mainImageUrl: "/images/button/back57.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: mainColor,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT,
        orientation: Orientation.est);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  resultOnMap(Parameters params) {
    fireApplicationEvent(new PageCallEvent(sender: this, pageName: PageMap.NAME));
  }
  search(Parameters params) {
    fireApplicationEvent(new PageCallEvent(sender: this, pageName: PageSearch.NAME));
  }
  cancel(Parameters params) {
    layout.style.backgroundColor = mainColor.lightColor;
  }
}
