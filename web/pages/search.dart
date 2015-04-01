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
import 'package:connecting_dartisans/client/elements/dartisans_search_form.dart';

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
  DartisansSearchFormElement form;

  PageSearch.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    form = $["form"] as DartisansSearchFormElement;
    form.setApplicationEventBus(this.applicationEventBus);

    LayoutModel layoutModel = new LayoutModel( color: Color.WHITE);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    // TODO Find another way to do this
    form.setApplicationEventBus(this.applicationEventBus);
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
