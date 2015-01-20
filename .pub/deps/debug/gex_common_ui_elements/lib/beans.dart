part of gex_common_ui_elements;

enum ScreenOrientation { LANDSCAPE , PORTRAIT }



class Parameter{
  String _key ;
  String _value;
  
  Parameter(this._key,this._value) ;
  
  String get key => _key;
  String get value => _value;
  
  Parameter clone(){
    return new Parameter(this._key,this._value) ;
  }
}

class Parameters{
  List<Parameter> _parameters ;
  
  Parameters(List<Parameter> parameters){
    if (parameters == null){
      _parameters = new List<Parameter>() ;
    }else{
      _parameters = parameters;
    }
  }
  
  List<Parameter> get parameters {
    List<Parameter> parameters = new List<Parameter>() ;
    _parameters.forEach((p)=> parameters.add(p));
    return parameters;
  } 
  
  void add(String key, String value){
    _parameters.add( new Parameter(key,value) ) ;
  }
  
  Parameters clone(){
    return new Parameters(parameters);
  }
}

class ActionDescriptor{
  
  String _name;
  String _description;
  LaunchAction _launchAction;
  
  ActionDescriptor({String name,String description,LaunchAction launchAction}){
    _name = name;
    _description = description;
    _launchAction = launchAction;
  }
  
  String get name => _name;
  String get description => _description == null ? _name : _description;
  LaunchAction get launchAction => _launchAction;
  
  ActionDescriptor clone(){
    return new ActionDescriptor(name:_name,description:_description,launchAction:launchAction);
  }
  
}

class Margin {
  
  num _leftInPx  ;
  num _rightInPx ;
  num _topInPx ;
  num _bottomInPx ;
  
  Margin( {num leftInPx, num rightInPx, num topInPx, num bottomInPx} ){
    _leftInPx = _value(leftInPx) ;
    _rightInPx = _value(rightInPx) ;
    _topInPx = _value(topInPx) ;
    _bottomInPx = _value(bottomInPx) ;
  }
  
  num _value(num value) => value == null ? 0 : value ;
  
  String get leftInPxAsString => "${_leftInPx}px" ;
  String get rightInPxAsString => "${_rightInPx}px" ;
  String get topInPxAsString => "${_topInPx}px" ;
  String get bottomInPxAsString => "${_bottomInPx}px" ;
    
  num get leftInPx => _leftInPx ;
  num get rightInPx => _rightInPx ;
  num get topInPx => _topInPx ;
  num get bottomInPx => _bottomInPx ; 
  
  Margin merge({num leftInPx, num rightInPx, num topInPx, num bottomInPx}){
    return new Margin(leftInPx:  leftInPx==null? _leftInPx : leftInPx,
                      rightInPx: rightInPx==null? _rightInPx : rightInPx,
                      topInPx: topInPx==null? _topInPx : topInPx,
                      bottomInPx: bottomInPx==null? _bottomInPx : bottomInPx) ;
  }
  
  Margin clone(){
    return new Margin(leftInPx:_leftInPx, rightInPx: _rightInPx,topInPx: _topInPx,bottomInPx: _bottomInPx) ;
  }
  
  
  
}




