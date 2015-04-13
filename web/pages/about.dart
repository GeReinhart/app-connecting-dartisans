library connecting_dartisans.pages.about;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/client/elements/layout.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';
import 'package:connecting_dartisans/client/elements/dartisan_summary.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';


@CustomTag('page-about')
class PageAbout extends Page with Showable {
  static final String NAME = "about";

  final String authorOpenId = "113123881058574339056";

  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;

  
  Layout layout;
  DartisanSummary author;

  PageAbout.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    author = $["author"] as DartisanSummary;
    author.style.cursor = "pointer";
    author.small = window.innerWidth < 600 ;
    author.onClick.listen((event) {
      fireApplicationEvent(new DartisansApplicationEvent.callDetails(this, author.dartisan.openId));
    });

    LayoutModel layoutModel = new LayoutModel(color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);

    if (event is DartisansApplicationEvent) {
      if (event.isSearchSuccess) {
        if (event.dartisans.dartisans.containsKey(authorOpenId)) {
          author.dartisan = event.dartisans.dartisans[authorOpenId];
        }
      }
    }
    if (event.isViewPortChange){
      author.small = event.viewPort.windowWidth < 600 ;
    }
  }
}
