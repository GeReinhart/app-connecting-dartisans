library connecting_dartisans.pages.login;

import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
import 'package:gex_webapp_kit/client/elements/layout.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';
import 'package:connecting_dartisans/client/elements/dartisan_edit.dart';
import 'package:connecting_dartisans/client/elements/dartisan_summary.dart';
import 'package:connecting_dartisans/client/elements/dartisan_details.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:paper_elements/paper_action_dialog.dart';

@CustomTag('page-profile')
class PageProfile extends Page with Showable {
  static final String NAME = "profile";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;

  Layout layout;
  DartisanEdit dartisanEdit;

  PageProfile.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  @override
  void show() {
    super.show();
    dartisanEdit.show();
  }

  @override
  void hide() {
    super.hide();
    dartisanEdit.hide();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    dartisanEdit = $["dartisanEdit"] as DartisanEdit;

    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels
        .add(new ButtonModel(label: "Save", action: save, image: new Image(mainImageUrl: "/images/button/save29.png")));
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

    if (event.isUserAuthSuccess) {
      dartisanEdit.userFromAuthentication = event.user;
    }
    if (event.isLoginSuccess || event.isRegisterSuccess) {
      dartisanEdit.user = event.user;
    }
    if (event.isUserDetailsSuccess) {
      dartisanEdit.dartisan = event.user as Dartisan;
    }
    if (event.isLogoutSuccess) {
      dartisanEdit.dartisan = new Dartisan();
    }
    if (event is DartisansApplicationEvent) {
      if (this.isShowed() && event.isSaveDartisanSuccess) {
        toastMessage("Profile saved", color: Color.BLUE_0082C8);
      }
    }
  }

  save(Parameters params) {
    fireApplicationEvent(new ApplicationEvent.callSaveUser(this, dartisanEdit.dartisan));
  }

  logout(Parameters params) {
    // TODO Should call logout first...
    fireApplicationEvent(new ApplicationEvent.logoutSuccess(this, dartisanEdit.dartisan));
    dartisanEdit.dartisan = new Dartisan();
  }

  PaperActionDialog get dialogPreview => $["dialogPreview"] as PaperActionDialog;
  DartisanDetails get details => $["details"];
  DartisanSummary get summary => $["summary"];
}
