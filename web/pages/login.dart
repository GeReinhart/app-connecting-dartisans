library connecting_dartisans.pages.login;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

import '../application.dart' ;

@CustomTag('page-login')
class PageLogin extends Page with Showable  {
  
  final Logger log = new Logger('PageLogin');
  
  Color mainColor = ConnectingDartisansApplication.DART_BLUE_ORANGE.lightColorAsColor;
    
    Layout layout ;
    
    PageLogin.created() : super.created() ;
    
    
    ready() {
      super.ready();
      _setAttributes();
    }
    
    void _setAttributes(){
       layout = $["layout"] as Layout ;
       
       List<ButtonModel> buttonModels = new List<ButtonModel>();
       buttonModels.add( new ButtonModel(label: "Login & Search",action:loginAndSearch,image:new Image(mainImageUrl:  "/images/button/login.png",mainImageUrl2:"/images/button/search54.png") )  );
       buttonModels.add( new ButtonModel(label: "Login & Map",action:loginAndMap,image:new Image(mainImageUrl:  "/images/button/login.png" ,mainImageUrl2:  "images/button/map32.png" ) )  );
       buttonModels.add( new ButtonModel(label: "Cancel",action:cancel,image:new Image(mainImageUrl:  "/images/button/back57.png") )  );
       ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor, orientation: Orientation.est,colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );  

       LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel,color: mainColor);
       PageModel model = new PageModel(layoutModel:layoutModel );
       this.init(model) ;
       
     }
    
    loginAndSearch(Parameters params){
      // TODO Login
      fireApplicationEvent(new PageCallEvent( sender: this,  pageName:'PageSearch' )  );
    }
    loginAndMap(Parameters params){
      // TODO Login
      fireApplicationEvent(new PageCallEvent( sender: this,  pageName:'PageMap' )  );
    }
    cancel(Parameters params){
      layout.style.backgroundColor =mainColor.lightColor ;
    }
  
  
}
