library connecting_dartisans.pages.login;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/layout.dart' ;
import 'package:gex_common_ui_elements/elements/page.dart' ;

import '../application.dart' ;

@CustomTag('page-register')
class PageRegister extends Page with Showable  {
  
  final Logger log = new Logger('PageRegister');
  
  Color mainColor = ConnectingDartisansApplication.DART_BLUE_ORANGE.lightColorAsColor;
    
    Layout layout ;
    
    PageRegister.created() : super.created() ;
    
    
    ready() {
      super.ready();
      _setAttributes();
    }
    
    void _setAttributes(){
       layout = $["layout"] as Layout ;
       
       List<ButtonModel> buttonModels = new List<ButtonModel>();
       buttonModels.add( new ButtonModel(label: "Save & Map",action:action1,image:new Image(mainImageUrl:  "/images/button/save29.png",mainImageUrl2:"/images/button/map32.png" ))  );
       buttonModels.add( new ButtonModel(label: "Save & Stay",action:action2,image:new Image(mainImageUrl:  "/images/button/save29.png" ))  );
       buttonModels.add( new ButtonModel(label: "Cancel" ,action:action3,image:new Image(mainImageUrl:  "/images/button/back57.png")  ));
       ToolbarModel toolbarModel = new ToolbarModel(buttons:buttonModels, color: mainColor,colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT , orientation: Orientation.est);  

       LayoutModel layoutModel = new LayoutModel(toolbarModel: toolbarModel,color: mainColor);
       PageModel model = new PageModel(layoutModel:layoutModel );
       this.init(model) ;
       
     }
    
    action1(Parameters params){
      layout.style.backgroundColor =mainColor.strongColor ;
    }
    action2(Parameters params){
      layout.style.backgroundColor =mainColor.mainColor ;
    }
    action3(Parameters params){
      layout.style.backgroundColor =mainColor.lightColor ;
    }
  
  
}