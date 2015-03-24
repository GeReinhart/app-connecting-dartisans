library connecting_dartisans.pages.stats;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/layout.dart';
import 'package:gex_webapp_kit_client/elements/page.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:modern_charts/modern_charts.dart';

import '../application.dart';
import 'list.dart';
import 'map.dart';
import 'search.dart';
import 'profile.dart';

@CustomTag('page-stats')
class PageStats extends Page with Showable {
  static final String NAME = "stats";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;
  @observable Dartisans dartisans;
  @observable num pieSize = 500;

  Layout layout;

  PageStats.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;

    LayoutModel layoutModel = new LayoutModel();
    PageModel model = new PageModel(name: NAME, layoutModel: layoutModel);
    this.init(model);
  }

  @override
  void show() {
    super.show();
    _updateCharts();
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    if (event is DartisansApplicationEvent) {
      if (event.isSearchSuccess || event.isMapChangeDartisans) {
        this.dartisans = event.dartisans;
      }
    }
  }

  void _updateCharts() {
    Map<String, num> dartisansByLevel = new Map<String, num>();
    dartisansByLevel[new Dartisan.fromFields(level: 1).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 2).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 3).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 4).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 5).levelLabel] = 0;

    dartisans.dartisanList.forEach((d) {
      num number = dartisansByLevel[d.levelLabel];
      if (number == null) {
        dartisansByLevel[d.levelLabel] = 1;
      } else {
        dartisansByLevel[d.levelLabel] = number + 1;
      }
    });

    List<List> data = new List<List>();
    data.add(["Dartisans", "Level"]);
    dartisansByLevel.keys.forEach((level) => data.add([level, dartisansByLevel[level]]));
    var table = new DataTable(data);
    var chart = new PieChart($["pieByLevel"]);
    chart.draw(table, {'series': {'labels': {'enabled': true}}});
    pieSize++;
    chart.resize();
    pieSize--;
    chart.resize();
  }
}
