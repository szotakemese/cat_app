
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  static String m0(task) => 'Deleted "$task"';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
        'favourites': MessageLookupByLibrary.simpleMessage('Favourites'),
        'profile': MessageLookupByLibrary.simpleMessage('Profile'),
        'allCatsList': MessageLookupByLibrary.simpleMessage('All Cats List'),
        'undo': MessageLookupByLibrary.simpleMessage('Undo')
      };
}