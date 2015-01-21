library connecting_dartisans.app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;

@CustomTag('connecting-dartisans')
class ConnectingDartisansApplication  extends Application{
  
  
  static final Color DART_BLUE_ORANGE = new Color("#013552","#005B8C","#0082C8","#59ACD9","#99C6DE",      
                                             "#EF4716","#FF7415","#FFAB15","#FFC866","#FFDEA3");
  
  final Logger log = new Logger('ConnectingDartisansApplication');
  
  Color mainColor = DART_BLUE_ORANGE.inverseLightColorAsColor ;
  
  ConnectingDartisansApplication.created() : super.created(){
  } 
  
  @override
  void ready() {
    super.ready();
    
    _setAttributes();
  }
  
  void _setAttributes() {
    addPage( new Element.tag('page-home') ) ;
    addPage( new Element.tag('page-search') ) ;
    addPage( new Element.tag('page-map') ) ;
    addPage( new Element.tag('page-list') ) ;
    addPage( new Element.tag('page-login') ) ;
    addPage( new Element.tag('page-register') ) ;
    addPage( new Element.tag('page-about') ) ;
    addPage( new Element.tag('page-details') ) ;
    
    List<ButtonModel> topToolbar = new List<ButtonModel>();
    topToolbar.add( new ButtonModel(label: "Home", image: "images/button/back57.png",action:(p)=>showPage(pageIndex: 0) )  );
    topToolbar.add( new ButtonModel(label: "Search", image: "images/button/search54.png",action:(p)=>showPage(pageIndex: 1) )  );
    topToolbar.add( new ButtonModel(label: "Map", image: "images/button/map32.png",action:(p)=>showPage(pageIndex: 2) )  );
    topToolbar.add( new ButtonModel(label: "List", image: "images/button/list23.png",action:(p)=>showPage(pageIndex: 3) )  );
    ToolbarModel topToolbarModel = new ToolbarModel(buttons:topToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(topToolbarModel);
    
    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add( new ButtonModel(label: "Login", image: "images/button/login.png",action:(p)=>showPage(pageIndex: 4) )  );
    bottomToolbar.add( new ButtonModel(label: "Register", image: "images/button/create1.png",action:(p)=>showPage(pageIndex: 5) )  );
    bottomToolbar.add( new ButtonModel(label: "About", image: "images/button/info24.png",action:(p)=>showPage(pageIndex: 6) )  );
    ToolbarModel bottomToolbarModel = new ToolbarModel(buttons:bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(bottomToolbarModel);    
    
    fitWithWindow();
    pages[0].show();
  }
  
  
}
