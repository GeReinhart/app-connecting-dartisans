library connecting_dartisans.app;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_common_ui_elements/common_ui_elements.dart' ;
import 'package:gex_common_ui_elements/elements/application.dart' ;
import 'pages/about.dart' ;
import 'pages/details.dart' ;
import 'pages/home.dart' ;
import 'pages/list.dart' ;
import 'pages/login.dart' ;
import 'pages/map.dart' ;
import 'pages/register.dart' ;
import 'pages/search.dart' ;

@CustomTag('connecting-dartisans')
class ConnectingDartisansApplication  extends Application{
  
  
  static final Color DART_BLUE_ORANGE = new Color("#013552","#005B8C","#0082C8","#59ACD9","#99C6DE",      
                                             "#EF4716","#FF7415","#FFAB15","#FFC866","#FFDEA3");

  static final Color DART_LIGHT_BLUE_ORANGE = new Color("#005B8C","#0082C8","#59ACD9","#99C6DE","#B6CEDB",      
                                             "#FF7415","#FFAB15","#FFC866","#FFDEA3", "#FFEDCC");
  
    static final Color GREY_BLUE_GREEN = new Color("#40494D","#7F8D94","#ABB3B8","#C3C7C9","#E3E3E3",
                                             "#7D8A67","#939E82","#ACB89A","#CBD1C0","#DEE0DA" ) ;
  
  final Logger log = new Logger('ConnectingDartisansApplication');
  
  Color mainColor = DART_BLUE_ORANGE ;
  
  ConnectingDartisansApplication.created() : super.created(){
  } 
  @override
  void ready() {
    super.ready();
    
    _setAttributes();
    this.setApplicationEventBus(new ApplicationEventBus() );
    fireApplicationEvent(new PageCallEvent( sender: this,  pageName:'PageHome' )  );
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
    topToolbar.add( new ButtonModel(label: "Home", image: new Image(mainImageUrl:  "images/button/back57.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageHome")   )  );
    topToolbar.add( new ButtonModel(label: "Search", image:new Image(mainImageUrl:  "images/button/search54.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageSearch") )  );
    topToolbar.add( new ButtonModel(label: "Map", image:new Image(mainImageUrl:  "images/button/map32.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageMap") )  );
    topToolbar.add( new ButtonModel(label: "List", image: new Image(mainImageUrl: "images/button/list23.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageList") )  );
    ToolbarModel topToolbarModel = new ToolbarModel(buttons:topToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(topToolbarModel);
    
    List<ButtonModel> bottomToolbar = new List<ButtonModel>();
    bottomToolbar.add( new ButtonModel(label: "Login", image:new Image(mainImageUrl:  "images/button/login.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageLogin") )  );
    bottomToolbar.add( new ButtonModel(label: "Register", image: new Image(mainImageUrl: "images/button/create1.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageRegister") )  );
    bottomToolbar.add( new ButtonModel(label: "About", image: new Image(mainImageUrl: "images/button/info24.png"),type: ButtonType.PAGE_LAUNCHER , targetPageKey: new PageKey(name: "PageAbout") )  );
    ToolbarModel bottomToolbarModel = new ToolbarModel(buttons:bottomToolbar, color: mainColor, colorUsage: ColorUsage.ALTERNATE_WITH_LIGHT );
    addToolbar(bottomToolbarModel);    
    
    fitWithWindow();
  }
  
  
}
