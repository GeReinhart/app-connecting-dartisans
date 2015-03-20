library connecting_dartisans.pages.search;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/ternary_options.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';

import '../application.dart';
import 'list.dart';
import 'map.dart';
import 'search.dart';

@CustomTag('page-search')
class PageSearch extends Page with Showable {
  static final String NAME = "search";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;

  Layout layout;

  PageSearch.created() : super.created();

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
        label: "Result as list", action: resultOnList, image: new Image(mainImageUrl: "/images/button/list23.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: Color.GREY_858585.lightColorAsColor,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT,
        orientation: Orientation.est);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: Color.WHITE);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  resultOnMap(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageMap.NAME));
  }
  resultOnList(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageList.NAME));
  }
  cancel(Parameters params) {
    layout.style.backgroundColor = Color.WHITE.mainColor;
  }
}
