library connecting_dartisans.pages.login;

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

@CustomTag('page-profile')
class PageProfile extends Page with Showable {
  static final String NAME = "profile";
  final Logger log = new Logger(NAME);

  Color mainColor = ConnectingDartisansApplication.GREY_BLUE_GREEN.inverse();

  @observable User user;
  Layout layout;

  PageProfile.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(new ButtonModel(
        label: "Save & Map",
        action: saveAndMap,
        image: new Image(mainImageUrl: "/images/button/save29.png", mainImageUrl2: "/images/button/map32.png")));
    buttonModels.add(new ButtonModel(
        label: "Save & Stay", action: save, image: new Image(mainImageUrl: "/images/button/save29.png")));
    buttonModels.add(
        new ButtonModel(label: "Cancel", action: cancel, image: new Image(mainImageUrl: "/images/button/back57.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: mainColor,
        orientation: Orientation.est,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event is UserAuthEvent) {
      user = event.user;
    }
  }

  save(Parameters params) {
    // TODO Save
  }
  saveAndMap(Parameters params) {
    // TODO Login
    fireApplicationEvent(new PageCallEvent(sender: this, pageName: PageMap.NAME));
  }
  cancel(Parameters params) {
    // TODO Cancel
    layout.style.backgroundColor = mainColor.lightColor;
  }
}
