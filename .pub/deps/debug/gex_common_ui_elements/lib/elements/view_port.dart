library gex_common_ui_elements.virtual_screen;

import "dart:html";
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_common_ui_elements/common_ui_elements.dart';
import 'package:polymer/polymer.dart';

/**
 * Listen to the screen/window changes and broadcast ViewPort change events.
 */
@CustomTag('gex-view-port')
class ViewPort extends Positionable with Showable {
  
  final Logger log = new Logger('ViewPort');
  
  ViewPortModel _model ;
  StreamController<ViewPortChangeEvent> _viewPortChangeEventStream ;
  
  ViewPort.created() : super.created();
  
  @override
  void ready() {
    super.ready();
    _viewPortChangeEventStream = new StreamController<ViewPortChangeEvent>.broadcast(sync: false);
    _updateViewPort(); 
  }
  
  ViewPortModel get model => _model.clone();
  
  void subscribeViewPortChange( ViewPortChangeCallBack callBack  ){
    _viewPortChangeEventStream.stream.listen((ViewPortChangeEvent event) => callBack(event.clone()));
  }
  
  void _updateViewPort(){
    ViewPortModel newScreen = new ViewPortModel.fromWindow( window  ) ;
    if (newScreen != _model  ){
      _model = newScreen ;
      log.info("ViewPort ${id} changed to ${_model}");
      _viewPortChangeEventStream.add( new ViewPortChangeEvent(_model) ) ;
    }
    var wait = new Duration(milliseconds: 125);
    new Timer(wait, ()=> _updateViewPort());
  }
  
}

