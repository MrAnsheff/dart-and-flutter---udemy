import 'dart:async';

class Order {
  final String type;
  Order(this.type);
}

class Cake {}

void main() {
  final controller = StreamController();

  final baker = StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == "chocolate") {
      sink.add(Cake());
    } else
      sink.addError("I cant bake that type!");
  });

  controller.stream.map((order) => order.type).transform(baker).listen(
      (cake) => print("Heres your cake: $cake"),
      onError: (error) => print(error));

  final order = Order("banana");
  controller.sink.add(order);
  final order2 = Order("chocolate");
  controller.sink.add(order2);
}
