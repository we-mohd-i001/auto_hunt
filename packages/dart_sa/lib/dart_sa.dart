import 'dart:isolate';
import 'dart:mirrors';

void main(List<String> args) async {
  final person = Person('John', 20);
  String str = 'Why';
  print(person);

  final foo = await Isolate.run(() {
    print('Hello from isolate');
    str = 'Why number';
    return str + ' 123?';
  });

  print(str);
  final house = House('123 Main St', 2000);

  print(house);
  print(foo);
}

extension AsKey on VariableMirror {
  String get asKey {
    final fieldname = MirrorSystem.getName(simpleName);
    final fieldType = MirrorSystem.getName(type.simpleName);
    return '$fieldname ($fieldType)';
  }
}

mixin HasDescription {
  @override
  String toString() {
    final reflection = reflect(this);
    final thisType = MirrorSystem.getName(
      reflection.type.simpleName,
    );

    final variables =
        reflection.type.declarations.values.whereType<VariableMirror>();

    final properties = <String, dynamic>{
      for (final field in variables)
        field.asKey: reflection
            .getField(
              field.simpleName,
            )
            .reflectee
    }.toString();
    return '$thisType $properties';
  }
}

class Person with HasDescription {
  String name;
  int age;

  Person(
    this.name,
    this.age,
  );
}

class House with HasDescription {
  String address;
  int price;

  House(
    this.address,
    this.price,
  );
}
