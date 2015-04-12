library connecting_dartisans.pages.stats;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/client/elements/layout.dart';
import 'package:gex_webapp_kit/client/elements/page.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:modern_charts/modern_charts.dart';

@CustomTag('page-stats')
class PageStats extends Page with Showable {
  static final String NAME = "stats";
  final Logger log = new Logger(NAME);

  Color mainColor = Color.WHITE;
  @observable Dartisans dartisans;
  bool small = false;

  Layout layout;
  DivElement pieByLevelContainer;
  DivElement pieByCountryContainer;
  DivElement pieAtWorkContainer;

  PageStats.created() : super.created();

  ready() {
    super.ready();
    small = window.innerWidth < 800;

    _setAttributes();
  }

  void _setAttributes() {
    layout = $["layout"] as Layout;
    pieByLevelContainer = $["pieByLevelContainer"];
    pieByCountryContainer = $["pieByCountryContainer"];
    pieAtWorkContainer = $["pieAtWorkContainer"];
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
    if (event.isViewPortChange) {
      small = window.innerWidth < 800;
      _updateCharts();
    }
  }

  Element createPieDiv(Element container) {
    if (container.children.isNotEmpty) {
      container.children.clear();
    }
    num pieWidth;
    num pieHeight;
    if (small) {
      pieWidth = window.innerWidth * 0.7;
      pieHeight = pieWidth;
    } else {
      pieWidth = 800;
      pieHeight = 350;
    }

    var e = new DivElement()
      ..style.height = '${pieHeight}px'
      ..style.width = '${pieWidth}px'
      ..style.maxWidth = '100%'
      ..style.marginBottom = '5px';
    container.append(e);
    return e;
  }

  void _updateCharts() {
    PieChart pieByLevelChart = new PieChart(createPieDiv(pieByLevelContainer));
    Map<String, num> dartisansByLevel = new Map<String, num>();
    dartisansByLevel[new Dartisan.fromFields(level: 1).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 2).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 3).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 4).levelLabel] = 0;
    dartisansByLevel[new Dartisan.fromFields(level: 5).levelLabel] = 0;

    if (dartisans == null) {
      return;
    }

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
    if (small) {
      pieByLevelChart.draw(tableLevel, {'series': {'labels': {'enabled': false}}, 'legend': {'position': 'none'}});
    } else {
      pieByLevelChart.draw(tableLevel, {'series': {'labels': {'enabled': false}}});
    }
    pieByLevelChart.update();

    PieChart pieByCountryChart = new PieChart(createPieDiv(pieByCountryContainer));
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

    if (small) {
      pieByCountryChart.draw(tableCountry, {'series': {'labels': {'enabled': false}}, 'legend': {'position': 'none'}});
    } else {
      pieByCountryChart.draw(tableCountry, {'series': {'labels': {'enabled': false}}});
    }
    pieByCountryChart.update();

    PieChart pieAtWorkChart = new PieChart(createPieDiv(pieAtWorkContainer));
    Map<String, num> dartisansAtWork = new Map<String, num>();
    dartisans.dartisanList.forEach((d) {
      num number = dartisansAtWork[d.atWorkLabel];
      if (number == null) {
        dartisansAtWork[d.atWorkLabel] = 1;
      } else {
        dartisansAtWork[d.atWorkLabel] = number + 1;
      }
    });

    List<List> dataAtWork = new List<List>();
    dataAtWork.add(["Dartisans", "At work"]);
    dartisansAtWork.keys.forEach((atWork) => dataAtWork.add([atWork, dartisansAtWork[atWork]]));
    var tableAtWork = new DataTable(dataAtWork);
    if (small) {
      pieAtWorkChart.draw(tableAtWork, {'series': {'labels': {'enabled': false}}, 'legend': {'position': 'none'}});
    } else {
      pieAtWorkChart.draw(tableAtWork, {'series': {'labels': {'enabled': false}}});
    }
    pieAtWorkChart.update();
    pieAtWorkChart.update();
  }
}
