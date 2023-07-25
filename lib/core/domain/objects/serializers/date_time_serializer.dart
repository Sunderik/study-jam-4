import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  final Iterable<Type> types = BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'location';

  @override
  Object serialize(Serializers serializers, DateTime location, {FullType specifiedType = FullType.unspecified}) {
    return location.toIso8601String();
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return DateTime.parse(serialized as String);
  }
}
