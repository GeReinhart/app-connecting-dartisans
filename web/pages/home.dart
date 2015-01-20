library connecting_dartisans.pages.home;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

import '../application.dart' ;

@CustomTag('page-home')
class PageHome extends Page with Showable {
  
  final Logger log = new Logger('PageOne');
  
  Color mainColor = ConnectingDartisansApplication.DART_BLUE_ORANGE.lightColorAsColor;
  
  Layout layout ;
  ImageElement dartLogo ;
  
  PageHome.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes(){
     layout = $["layout"] as Layout ;
     dartLogo = $["dartLogo"] as ImageElement ;
     
     LayoutModel layoutModel = new LayoutModel();
     PageModel model = new PageModel( layoutModel:layoutModel);
     this.init(model) ;
  }
  
  @override
  void moveTo(Position position) {
    super.moveTo(position);
    num dartLogoWidth = position.width / 3 > 400 ? 400: position.width / 3 ;
    dartLogo.style.width = "${dartLogoWidth}px" ;
  }
}