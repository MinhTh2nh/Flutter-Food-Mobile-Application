import 'package:flutter/material.dart';

class AddressManagement extends StatefulWidget {
  final void Function(String address, String phoneNumber)? onAddressSelected;

const AddressManagement({super.key, this.onAddressSelected});
  @override
  // ignore: library_private_types_in_public_api
  _AddressManagementState createState() => _AddressManagementState();
}

class _AddressManagementState extends State<AddressManagement> {
  final _formKey = GlobalKey<FormState>();
  List<Address> deliveryAddresses = [
    Address(
      address: '123 Main St, New York, NY',
      phoneNumber: '123-456-7890',
    ),
    Address(
      address: '456 Elm St, New York, NY',
      phoneNumber: '123-456-7890',
    ),
  ];
  void addAddress(String address) {
    setState(() {
      deliveryAddresses.add(address as Address);
    });
  }

  void removeAddress(int index) {
    setState(() {
      deliveryAddresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: deliveryAddresses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(deliveryAddresses[index].address),
                subtitle: Text(deliveryAddresses[index].phoneNumber),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    removeAddress(index);
                  },
                ),
                onTap: () {
                  widget.onAddressSelected!(deliveryAddresses[index].address , deliveryAddresses[index].phoneNumber);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        ElevatedButton(
          child: const Text('Add Address'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Address'),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Country'),
                          onSaved: (value) {
                            // Save country
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'City'),
                          onSaved: (value) {
                            // Save city
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Street'),
                          onSaved: (value) {
                            // Save street
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                          onSaved: (value) {
                            // Save phone
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Add address to the list
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class Address {
  final String address;
  final String phoneNumber;

  Address({required this.address, required this.phoneNumber});
}
