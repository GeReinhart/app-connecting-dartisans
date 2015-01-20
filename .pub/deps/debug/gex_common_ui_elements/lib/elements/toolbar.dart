library gex_common_ui_elements.toolbar;

import "dart:html" hide ScreenOrientation;
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:gex_common_ui_elements/elements/button.dart';

/**
 * Display buttons to create a toolbar.
 */
@CustomTag('gex-toolbar') 
class Toolbar extends Positionable with Showable {
  
  final Logger log = new Logger('Toolbar');
  
  ToolbarModel _model ;
  List<Button> _buttons ;
  
  Toolbar.created() : super.created() ;
  
  ToolbarModel get model => _model.clone();
  
  set orientation(Orientation value){
    _model.orientation = value ;
  }
  
  factory Toolbar.fromModel(ToolbarModel model){
    Toolbar toolbar = new Element.tag('gex-toolbar') as Toolbar;
    toolbar.init(model);
    return toolbar ;
  }
  
  void init(ToolbarModel model) {
    _model = model ;
    _initButtons(model);
  }
  
  @override
  void moveTo(Position position){
    if(_buttons == null){
      throw new Exception("On ToolBar call 'init' before 'moveTo'");
    }    
    if (isCurrentPostion(position)){
      return ;
    }
    _moveButtons(position);
    super.moveTo(this.position);
  }
  
  void _initButtons( ToolbarModel model) {
    this._buttons = new List<Button>();
    List<ButtonModel> buttonModels = model.buttons;
    for (var i = 0; i < buttonModels.length; i++) {
      Button button = new Element.tag('gex-button') as Button;
      this.append(button);
      _buttons.add(button);
      button.init( buttonModels[i]..color = model.getColorForBackGround(i)) ;
    }
  }
 
  void _moveButtons(Position position) {
    _model.mainButtonPosition = position;
    this.position.merge(position) ;
    
    for (var i = 0; i < _buttons.length; i++) {
      Button button = _buttons[i];
      
      num left = 0;
      if ( Orientation.est ==  _model.orientation ){
        left =  i * position.width ;
      }
      if ( Orientation.west ==  _model.orientation ){
        left =  (_model.nbActions - i -1 ) * position.width ;
      }
      
      num top = 0;
      if ( Orientation.south ==  _model.orientation ){
        top =  i * position.height ;
      }
      if ( Orientation.north ==  _model.orientation ){
        top =  (_model.nbActions - i -1 )* position.height ;
      }      
      Position currentPostion = position.clone() ;
      currentPostion..left = left
                    ..top = top ;
      
      button.moveTo(currentPostion) ;
    }
    
    if ( Orientation.est ==  _model.orientation ){
      this.position.width = _model.nbActions * position.width ;
    }
    if ( Orientation.west ==  _model.orientation ){
      this.position.left =  position.left - (_model.nbActions-1)* position.width ;
      this.position.width =  _model.nbActions * position.width ;
    }
    if ( Orientation.south ==  _model.orientation ){
      this.position.height =  _model.nbActions * position.height ;
    }
    if ( Orientation.north ==  _model.orientation ){
      this.position.top =  position.top - (_model.nbActions-1)* position.height ;
      this.position.height =  _model.nbActions * position.height ;
    }    
  }  
  
  List<Position> get buttonPositions{
    List<Position> positions = new List<Position>();
    _buttons.forEach((b){
      positions.add(b.position);
    });
    return positions;
  }
  
}
