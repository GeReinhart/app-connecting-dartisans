library connecting_dartisans.pages.details;

import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
import 'package:gex_webapp_kit/client/elements/layout.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/client/elements/dartisan_details.dart';

@CustomTag('page-details')
class PageDetails extends Page with Showable {
  static final String NAME = "dartisan";
  final Logger log = new Logger('NAME');

  Color mainColor = Color.WHITE;

  Layout layout;

  String _dartisanOpenId;

  PageDetails.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    LayoutModel layoutModel = new LayoutModel(color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void show() {
    super.show();
    details.show();
  }

  @override
  void showPage({Parameters resources, Parameters params}) {
    if (resources != null) {
      fireApplicationEvent(new DartisansApplicationEvent.callDetails(this, resources.valueFor("id")));
    }
    show();
  }

  @override
  void hide() {
    super.hide();
    details.hide();
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event is DartisansApplicationEvent) {
      if (event.isDetailsSuccess) {
        details.dartisan = event.dartisan;
      }
    }
  }

  DartisanDetails get details => $["details"] as DartisanDetails;
}
