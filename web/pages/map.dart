library connecting_dartisans.pages.map;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

import '../application.dart' ;

@CustomTag('page-map')
class PageMap extends Page with Showable {
  
  final Logger log = new Logger('PageMap');
  
  Color mainColor = ConnectingDartisansApplication.DART_BLUE_ORANGE.lightColorAsColor;
  
  Layout layout ;
  
  PageMap.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes(){
     layout = $["layout"] as Layout ;
     
     LayoutModel layoutModel = new LayoutModel(color: mainColor);
     PageModel model = new PageModel( layoutModel:layoutModel);
     this.init(model) ;
  }
       
}