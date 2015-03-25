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
  @observable num pieSize = 400;

  Layout layout;
  PieChart pieByLevelChart;
  PieChart pieByCountryChart;

  PageStats.created() : super.created();

  ready() {
    super.ready();
    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    pieByLevelChart = new PieChart($["pieByLevel"]);
    pieByCountryChart = new PieChart($["pieByCountry"]);
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

    List<List> dataLevel = new List<List>();
    dataLevel.add(["Dartisans", "Level"]);
    dartisansByLevel.keys.forEach((level) => dataLevel.add([level, dartisansByLevel[level]]));
    var tableLevel = new DataTable(dataLevel);
    pieByLevelChart.draw(tableLevel, {'series': {'labels': {'enabled': true}}});
    pieByLevelChart.update();

    Map<String, num> dartisansByCountry = new Map<String, num>();
    dartisans.dartisanList.forEach((d) {
      num number = dartisansByCountry[d.country];
      if (number == null) {
        dartisansByCountry[d.country] = 1;
      } else {
        dartisansByCountry[d.country] = number + 1;
      }
    });

    List<List> dataCountry = new List<List>();
    dataCountry.add(["Dartisans", "Country"]);
    dartisansByCountry.keys.forEach((country) => dataCountry.add([country, dartisansByCountry[country]]));
    var tableCountry = new DataTable(dataCountry);
    pieByCountryChart.draw(tableCountry, {'series': {'labels': {'enabled': true}}});
    pieByCountryChart.update();
  }
}
