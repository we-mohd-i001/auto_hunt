abstract class Parent {
  factory Parent.createObject() {
    final Child child = Child();
    return child;
  }
  Parent();
  Object someMethod() {
    return 35;
  }
}

class Child extends Parent {
  @override
  String someMethod() {
    return '3';
  }
}

void main() {
  final Parent parent = Parent.createObject();
  print(parent.someMethod());
}
