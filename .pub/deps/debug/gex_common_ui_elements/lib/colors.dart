part of gex_common_ui_elements;

enum ColorUsage  { GRADATION, ALTERNATE , ALTERNATE_WITH_LIGHT , UNIFORM }

class Color{
  
  static final Color BLUE_0082C8 = new Color("#013552","#005B8C","#0082C8","#59ACD9","#99C6DE",      
                                             "#521E01","#8C3100","#C84600","#D98659","#DEB199");
  
  static final Color GREEN_07CC00 = new Color("#355E34","#4B8549","#63B061","#96D494","#C4E6C3",      
                                             "#5D345E","#834985","#AE61B0","#D294D4","#E5C3E6");

  static final Color GREY_858585 = new Color("#000000","#454545","#858585","#BABABA","#FFFFFF",      
                                             "#1F1E15","#57563A","#8F8D5E","#C9C785","#FCFAA7");
  
  static final Color WHITE = new Color("#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF",      
                                             "#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF");
  
  String _veryStrongColor ;
  String _strongColor ;
  String _mainColor ;
  String _lightColor ;
  String _veryLightColor ;
  
  String _inverseVeryStrongColor ;
  String _inverseStrongColor ;
  String _inverseMainColor ;
  String _inverseLightColor ;
  String _inverseVeryLightColor ;
  
  Color(this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor, this._veryLightColor,
        this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor
       );
  
  String get veryStrongColor => _veryStrongColor ;
  Color get veryStrongColorAsColor => new Color(this._veryStrongColor, this._veryStrongColor, this._veryStrongColor, this._strongColor, this._mainColor,
      this._inverseVeryStrongColor, this._inverseVeryStrongColor, this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor);
  
  String get strongColor => _strongColor ;
  Color get strongColorAsColor => new Color(this._veryStrongColor, this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor,
      this._inverseVeryStrongColor, this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor);
  
  String get mainColor => _mainColor ;
  
  String get lightColor => _lightColor ;
  Color get lightColorAsColor => new Color(this._strongColor, this._mainColor, this._lightColor, this._veryLightColor, this._veryLightColor,
      this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor, this._inverseVeryLightColor);
  
  String get veryLightColor => _veryLightColor ;
  Color get veryLightColorAsColor => new Color( this._mainColor, this._lightColor, this._veryLightColor,this._veryLightColor,this._veryLightColor,
       this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor, this._inverseVeryLightColor, this._inverseVeryLightColor);  
  
  String get inverseVeryStrongColor => _inverseVeryStrongColor ;
  Color get inverseVeryStrongColorAsColor => new Color( this._inverseVeryStrongColor, this._inverseVeryStrongColor, this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor,
                 this._veryStrongColor, this._veryStrongColor, this._veryStrongColor, this._strongColor, this._mainColor);  
  
  String get inverseStrongColor => _inverseStrongColor ;
  Color get inverseStrongColorAsColor => new Color(this._inverseVeryStrongColor, this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor,
            this._veryStrongColor, this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor);  
  
  String get inverseMainColor => _inverseMainColor ;
  Color get inverseMainColorAsColor => inverse();
  
  String get inverseLightColor => _inverseLightColor ;
  Color get inverseLightColorAsColor => new Color( this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor, this._inverseVeryLightColor,
            this._strongColor, this._mainColor, this._lightColor, this._veryLightColor, this._veryLightColor);  
  
  String get inverseVeryLightColor => _inverseVeryLightColor ;
  Color get inverseVeryLightAsColor => new Color( this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor, this._inverseVeryLightColor, this._inverseVeryLightColor,
            this._mainColor, this._lightColor, this._veryLightColor,this._veryLightColor,this._veryLightColor);   
  
  Color clone(){
    return new Color(this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor, this._veryLightColor,
        this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor);
  }
  
  Color inverse(){
    return new Color(this._inverseVeryStrongColor, this._inverseStrongColor, this._inverseMainColor, this._inverseLightColor, this._inverseVeryLightColor,
        this._veryStrongColor, this._strongColor, this._mainColor, this._lightColor, this._veryLightColor);
  }
}