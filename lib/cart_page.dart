import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';
// import 'package:shopping_app/global_variable.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // final cart = context.watch<CartProvider>().cart;
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  cartItem['imageUrl'].toString(),
                ),
                radius: 30,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Product',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          content: const Text(
                              'Are you sure to remove the product from cart?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // context.read<CartProvider>().removeProduct(cartItem);
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .removeProduct(cartItem);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              title: Text(
                cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['size']}'),
            );
          }),
    );
  }
}
