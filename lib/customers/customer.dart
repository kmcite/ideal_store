import '../main.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    @Default('') final String id,
    @Default('') final String name,
    required final String city,
    @Default(false) final bool editing,
    @Default(<String>[]) final List<String> products,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

final customersRM = RM.inject(
  () => <Customer>[],
  autoDisposeWhenNotUsed: false,
);
List<Customer> customers([List<Customer>? value]) {
  if (value != null) {
    customersRM
      ..state = value
      ..notify();
  }
  return customersRM.state;
}

void addCustomer(Customer customer) {
  customers(List.of(customers()..add(customer)));
}

void removeCustomer(Customer customer) {
  customers(List.of(customers()..remove(customer)));
}

void removeAllCustomers() => customers([]);
