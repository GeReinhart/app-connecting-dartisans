library connecting_dartisans.pages.details;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

import '../application.dart' ;

@CustomTag('page-details')
class PageDetails extends Page with Showable {
  
  static final String NAME = "dartisan" ;
  final Logger log = new Logger('NAME');
  
  Color mainColor = ConnectingDartisansApplication.DART_LIGHT_BLUE_ORANGE.lightColorAsColor;
  
  Layout layout ;
  
  PageDetails.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes(){
    layout = $["layout"] as Layout ;

    LayoutModel layoutModel = new LayoutModel(color: mainColor);
    PageModel model = new PageModel( name : NAME ,layoutModel:layoutModel);
    this.init(model) ;
     
   }
  
}