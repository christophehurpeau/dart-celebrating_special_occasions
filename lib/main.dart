import 'package:angular/angular.dart';
import 'dart:math' as Math;
import 'dart:convert' show JSON;
import 'package:intl/intl.dart';
//import 'package:intl/intl_browser.dart';

class Event{
  final DateTime date;
  final String title;
  
  Event(this.date, this.title);
  
  String get intlDate => new DateFormat.yMMMd().format(date);
}


@NgDirective(selector: '[events-controller]', publishAs: 'events')
class EventsCtrl {
  List<Event> events;
  String birthDateText;
  DateTime birthDate;
  
  EventsCtrl(){
    initEvents();
  }
  
  DateTime initEvents(){
    DateTime now = new DateTime.now();
    events = [];
    addEvent(new DateTime(now.year+1, 1, 1), 'New Year');
    return now;
  }
  
  void set() {
    if(birthDateText == null || birthDateText.isEmpty) birthDateText = '1989-07-30';
    birthDate = DateTime.parse(birthDateText);
    birthDateText = null;
    
    DateTime now = initEvents();
    addEvent(new DateTime(now.year+1, birthDate.month, birthDate.day),'Your anniversary');
    
    
    var diff = now.difference(birthDate);
    num nbDays = diff.inDays;
    
    num nextImportantDay = (nbDays/500).ceil()*500;
    addEvent(birthDate.add(new Duration(days: nextImportantDay)), 'Your ${nextImportantDay} day' );
    
    num nbWeeks = nbDays / 7;
    num nextImportantWeek = (nbWeeks/50).ceil()*50;
    addEvent(birthDate.add(new Duration(days: nextImportantWeek*7)), 'Your ${nextImportantWeek} week' );
    
    events.sort((Event a, Event b) => a.date.millisecondsSinceEpoch - b.date.millisecondsSinceEpoch);
  }
  
  void addEvent(DateTime date, String title){
    events.add(new Event(date, title));
  }
  
  void remove(Event event){
    events.remove(event);
  }
}