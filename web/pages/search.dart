library connecting_dartisans.pages.search;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

import '../application.dart' ;

@CustomTag('page-search')
class PageSearch extends Page with Showable {
  
  static final String NAME = "search" ;  
  final Logger log = new Logger(NAME);
  
  Color mainColor = ConnectingDartisansApplication.DART_LIGHT_BLUE_ORANGE.lightColorAsColor;
  
  Layout layout ;
  
  PageSearch.created() : super.created() ;
  
  
  ready() {
    super.ready();
    _setAttributes();
  }
  
  void _setAttributes(){
    layout = $["layout"] as Layout ;
    
    List<ButtonModel> buttonModels = new List<ButtonModel>();
    buttonModels.add( new ButtonModel(label: "Result on map",action:resultOnMap,image:new Image(mainImageUrl:"/images/button/map32.png") )  );
    buttonModels.add( new ButtonModel(label: "Result as list",action:resultOnList,image:new Image(mainImageUrl:"/images/button/list23.png") )  );
    buttonModels.add( new ButtonModel(label: "Cancel",action:cancel,image:new Image(mainImageUrl:"/images/button/back57.png") )  );
    ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT, orientation: Orientation.est );  

    LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel,color: mainColor);
    PageModel model = new PageModel(name: NAME, layoutModel:layoutModel );
    this.init(model) ;
     
   }

  resultOnMap(Parameters params){
    fireApplicationEvent(new PageCallEvent( sender: this,  pageName:'PageMap' )  );
  }
  resultOnList(Parameters params){
    fireApplicationEvent(new PageCallEvent( sender: this,  pageName:'PageList' )  );
  }
  cancel(Parameters params){
    layout.style.backgroundColor =mainColor.lightColor ;
  }
  
}