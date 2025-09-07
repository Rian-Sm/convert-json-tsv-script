import 'dart:io';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:pretty_json/pretty_json.dart';

class Converter {

  static Map<String,dynamic>? convertToJson(List<String> value) {
    Map<String,dynamic>? jsonSet = {};

    value.forEachIndexed((index, line) {
        if(index != 0 ){
          var values = line.split('\t');

          jsonSet[values[0]] = {
            value[0].split('\t')[1]: values[1],
            value[0].split('\t')[2]: values[2],
          };

          print({
            value[0].split('\t')[1]: values[1],
            value[0].split('\t')[2]: values[2],
          });
        }
      });
    return jsonSet;
  }

  static void convertToTsv (String jsonRaw, String filePath) {
    if (jsonRaw.isEmpty) return;

    var jsonData = json.decode(jsonRaw);
    var file = File(filePath);
    var sink = file.openWrite();

    sink.writeln('slug\ttitle\tdescription');

    jsonData.forEach((key, value) {
      sink.writeln('$key\t${value['title']}\t${value['description']}');
    });

    sink.close();
  }

  static void convertTsvToJson(String filePath) {
    var file = File(filePath);

    file.readAsLines().then((lines) {
      var jsonData = Converter.convertToJson(lines);

      String stringData = prettyJson(jsonData,indent: 2);

      File('${filePath.split('.').first}.json').writeAsString(stringData);

      print('value:\n\n${stringData.replaceAll(RegExp(r'\"'), "'")}');
    });
  }

  static void convertJsonToTsv(String filePath) {
    var file = File(filePath);
    print('ok');

    file.readAsLines().then((lines) {

   Converter.convertToTsv(
        lines.toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(',,', ',')
        .replaceAll('{,', '{')
        .replaceAll('\n', '')
        .replaceAll('  ', '')
        .replaceAll(', }', '}')
        .replaceAll('}},', '}}'),
        '${filePath.split('.').first}.tsv'
      );
      });
    }
  

static void main(List<String> arguments){
  print(arguments);

  if(arguments.length != 2) {
    print('Please provide file type and the file path as argument');
    return;
  }

  switch (arguments[0]) {
    case 'json':
      print('Converting json to tsv');
      Converter.convertJsonToTsv(arguments[1]);
      break;
    case 'tsv':
      print('Converting tsv to json');
      Converter.convertTsvToJson(arguments[1]);
      break;
    default:
      print('File type not supported');
      return;
  }
  }
}
