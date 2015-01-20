library gex_common_ui_elements.extensible_button;

import "dart:html";
import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';

import 'package:gex_common_ui_elements/common_ui_elements.dart';

import 'package:paper_elements/paper_shadow.dart';
import 'package:paper_elements/paper_button.dart';

/**
 * Change it's display according to the space it can take.
 * Execute the action on the click on the button.
 */
@CustomTag('gex-button')
class Button  extends Positionable with Actionable, Showable {

  final Logger log = new Logger('Button');
  final num MIN_SIZE_WITH_TEXT = 150 ;  
  final num HEIGHT_TEXT = 35 ;
  final num PART_USED_BY_IMAGE = .85 ;

  ButtonModel _model  ;
  
  Button.created() : super.created() ;
  
  String get label => _model.label;
  String get image => _model.image;
  String get backgroundColor => _model.color.mainColor;

  bool get isButtonLabelVisible => _labelSpan.style.display != "none" ;
  bool get isImageVisible => _imageElement.style.display != "none" && _imageElement.src.isNotEmpty ;
  
  SpanElement get _labelSpan => $["label"] as SpanElement;
  ImageElement get _imageElement => $["image"] as ImageElement;
  ImageElement get imageElement => _imageElement.clone(true);
  PaperShadow get _shadow => $["shadow"] as PaperShadow;
  PaperButton get _button => $["button"] as PaperButton; 
  DivElement get _colorElement => $["color"] as DivElement ;
  
  
  factory Button.fromModel(ButtonModel model){
    Button button = new Element.tag('gex-button') as Button;
    button.init(model);
    return button ;
  }
  
  
  void init(ButtonModel model){
    _model = model;
    _colorElement.style.backgroundColor = backgroundColor;
    if( _model.hasImage ){
      _imageElement.style.display = "inline" ;
      _imageElement.src = image ;
    }else{
      _imageElement.style.display = "none" ;
    }
    if(_model.hasLabel){
      _labelSpan.innerHtml = _model.label;
    }
    targetAction(model.actionDescriptor);
    
    this.onClick.listen((_)=>_launchAction());
    this.onMouseDown.listen((_)=>_shadow.z= 1);
    this.onMouseUp.listen(  (_)=>_shadow.z= 2);
  }
  
  void _launchAction(){
    launchAction(null);
  }

  @override
  void moveTo(Position position) {
    if(_model == null){
      throw new Exception("On Button call 'init' before 'moveTo'");
    }
    if (isCurrentPostion(position)){
      return ;
    }
    super.moveTo(position);
    
    num heightForImage  ;
    num heightForText = 0 ;
    if ( _model.hasImage &&  ( position.width < MIN_SIZE_WITH_TEXT || !_model.hasLabel  ) ){
      _labelSpan.style.display = "none" ;
      heightForImage = position.smallerSection ;
    }else{
      _labelSpan.style.display = "" ;
      heightForImage = position.smallerSection - HEIGHT_TEXT ;
      heightForText = HEIGHT_TEXT;
    }
    String squareSize  = "${heightForImage * PART_USED_BY_IMAGE}px";
    String smallMargin = "${heightForImage * (1-PART_USED_BY_IMAGE)/2 }px";
    String largeMargin = "${heightForImage * (1-PART_USED_BY_IMAGE)/2  + ( position.largerSection - position.smallerSection+heightForText)/2 }px";
    
    _imageElement.style
        ..width  = squareSize   
        ..height = squareSize
        ..top  = position.height < position.width ? smallMargin : largeMargin
        ..left = position.height > position.width ? smallMargin : largeMargin;
    
    _colorElement.style
        ..width  = "${position.width}px"   
        ..height = "${position.height}px"
        ..zIndex = "${position.zIndex -1}";
        
    try {
       Element internalButton = _button.shadowRoot.querySelector('div') ;
       internalButton.style
              ..width = "${position.width}px"
              ..height= "${position.height}px";
    } catch(exception) {
        log.fine("Unable to change size of the internal button of ExtensibleButton ${id}");
    }
  }
  
  @override
  Button clone(bool deep ){
    Button clone = (new Element.tag('gex-button')) as Button;
    clone.init(_model.clone());
    return clone;
  }
  
  Button cloneAndMove( Position position ){
    Button clone = this.clone(true);
    return clone..moveTo(position);
  }
  
}


