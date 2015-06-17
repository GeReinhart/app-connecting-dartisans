// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisans_filter_status;

import 'package:logging/logging.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_slider.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';

@CustomTag('dartisans-filter-status')
class DartisansFilterStatus extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisansFilterStatus');

  @observable num currentSelectionNb = 0;
  @observable num nbAllDartisans = 0;
  @observable bool filteredByMap = false;
  @observable bool filteredBySearchCriterias = false;

  DartisansFilterStatus.created() : super.created();

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is DartisansApplicationEvent) {
      if (event.isSearchSuccess || event.isMapChangeDartisans) {
        this.currentSelectionNb = event.dartisans.number;
        if (nbAllDartisans<currentSelectionNb){
          nbAllDartisans=currentSelectionNb;
        }
        
        if (event.isSearchSuccess){
          filteredBySearchCriterias = true;
        }
        if (event.isMapChangeDartisans){
          filteredByMap = true;
        }        
        
        if( currentSelectionNb ==  nbAllDartisans){
          filteredByMap = false;
          filteredBySearchCriterias = false;
        }
      }
    }

  }
}
