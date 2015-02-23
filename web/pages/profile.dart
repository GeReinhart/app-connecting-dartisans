library connecting_dartisans.pages.login;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:gex_webapp_kit_client/elements/user_edit.dart';

import '../application.dart';
import 'list.dart';
import 'map.dart';
import 'search.dart';

@CustomTag('page-profile')
class PageProfile extends Page with Showable {
  static final String NAME = "profile";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;

  Layout layout;
  UserEdit userEdit;

  PageProfile.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    userEdit = $["userEdit"] as UserEdit;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add(new ButtonModel(
        label: "Save & Map",
        action: saveAndMap,
        image: new Image(mainImageUrl: "/images/button/save29.png", mainImageUrl2: "/images/button/map32.png")));
    buttonModels.add(new ButtonModel(
        label: "Save & Stay", action: save, image: new Image(mainImageUrl: "/images/button/save29.png")));
    buttonModels.add(
        new ButtonModel(label: "Logout", action: logout, image: new Image(mainImageUrl: "/images/button/logout.png")));
    ToolbarModel toolbarModel = new ToolbarModel(
        buttons: buttonModels,
        color: Color.GREY_858585.lightColorAsColor,
        orientation: Orientation.est,
        colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT);

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel, color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event.isUserAuthSuccess || event.isLoginSuccess || event.isRegisterSuccess) {
      userEdit.user = event.user;
    }
    if (event.isLogoutSuccess) {
      userEdit.user = new User();
    }
  }

  save(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callSaveUser(this, userEdit.user));
  }
  saveAndMap(Parameters params) {
    save(params);
    fireApplicationEvent(new ApplicationEvent.callPage(this, PageMap.NAME));
  }
  logout(Parameters params) {
    // TODO Should call logout first...
    fireApplicationEvent(new ApplicationEvent.logoutSuccess(this, userEdit.user));
    userEdit.user = new User();
  }
}
