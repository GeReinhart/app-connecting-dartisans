library connecting_dartisans.pages.list;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:connecting_dartisans/client/elements/dartisan_summary.dart';

import '../application.dart';
import 'list.dart';
import 'map.dart';
import 'search.dart';

@CustomTag('page-list')
class PageList extends Page with Showable {
  static final String NAME = "list";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;
  Layout layout;
  Dartisans dartisans;

  PageList.created() : super.created();

  @override
  void ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    LayoutModel layoutModel = new LayoutModel( color: Color.WHITE);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  resultOnMap(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageMap.NAME));
  }
  search(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageSearch.NAME));
  }

  DivElement get listElement => $["list"] as DivElement;

  void updateList() {
    listElement.children.removeWhere((_) => true);
    UListElement ul = new UListElement();
    listElement.append(ul);
    dartisans.dartisanList.reversed.forEach((dartisan) {
      LIElement li = new LIElement();
      ul.append(li);
      DartisanSummary dartisanSummary = new DartisanSummary.newElement(dartisan);

      dartisanSummary.style.cursor = "pointer";
      dartisanSummary.onClick.listen((event) {
        fireApplicationEvent(new DartisansApplicationEvent.callDetails(this, dartisan.openId));
      });

      li.append(dartisanSummary);
    });
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is DartisansApplicationEvent) {
      if (event.isSearchSuccess || event.isMapChangeDartisans) {
        this.dartisans = event.dartisans;
        updateList();
      }
    }
  }
}
