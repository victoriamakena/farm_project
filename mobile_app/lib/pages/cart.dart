import 'package:flutter/material.dart';
import 'package:mobile_app/services/order_service.dart';
import 'package:provider/provider.dart';

import '../services/cart_service.dart';
import '../services/auth_service.dart';

import 'login.dart';
import 'orders.dart';

class CartPage extends StatefulWidget{
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();

}

class _CartPageState extends State<CartPage> {

Future<void> addOrder(List<CartItem>cart, user) async{

    final token = context.read<AuthService>().token;

    final data ={
      'products': cart.map((item) {
        return {
          'product_id': item.product.id,
          'quantity': item.quantity,
        };
      }).toList(), 
      'user_id': user.id
    };

    final success = await context.read<OrdersService>().addOrder(data, token);
    if (success) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text( "Order created successfully!", ),
          ),
        );
        context.read<CartService>().clearCart();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OrdersPage(),
          ),
        );

  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),

      body: Consumer<CartService>(
        builder: (context, cart, child) {

          // -----------------------------------------
          // EMPTY CART
          // -----------------------------------------

          if (cart.cart.isEmpty) {
            return _buildEmptyCart(context);
          }

          // -----------------------------------------
          // CART WITH ITEMS
          // -----------------------------------------

          return Column(
            children: [

              // Cart items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),

                  itemCount: cart.cart.length,

                  itemBuilder: (context, index) {
                    final item = cart.cart[index];

                    return _buildCartItem(
                      context,
                      cart,
                      item,
                    );
                  },
                ),
              ),

              // Bottom summary
              _buildCartSummary(
                context,
                cart,
              ),
            ],
          );
        },
      ),
    );
  }

  // ------------------------------------------------
  // CART ITEM
  // ------------------------------------------------

  Widget _buildCartItem(
    BuildContext context,
    CartService cart,
    CartItem item,
  ) {
    final product = item.product;

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ---------------------------------------
            // PRODUCT IMAGE
            // ---------------------------------------

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(14),

              child: Image.network(
                product.image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 14),

            // ---------------------------------------
            // PRODUCT INFORMATION
            // ---------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w600,
                        ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'KSh ${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight:
                              FontWeight.w600,
                        ),
                  ),

                  const SizedBox(height: 10),

                  // Quantity controls
                  Row(
                    children: [

                      // Minus
                      _quantityButton(
                        context,
                        icon: Icons.remove,
                        onPressed: () {
                          // context .read<CartService>().increaseQty(product);
                        },
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),

                        child: Text(
                          '${item.quantity}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                        ),
                      ),

                      // Plus
                      _quantityButton(
                        context,
                        icon: Icons.add,
                        onPressed: () {
                          // context.read<CartService>().increaseQty(product);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ---------------------------------------
            // SUBTOTAL
            // ---------------------------------------

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,

              children: [

                Text(
                  'KSh ${item.subtotal.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 15),

                IconButton(
                  onPressed: () {
                    context.read<CartService>().removeProduct(product);
                            
                  },

                  icon: const Icon(
                    Icons.delete_outline,
                  ),

                  tooltip: 'Remove',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // QUANTITY BUTTON
  // ------------------------------------------------

  Widget _quantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,

      borderRadius:
          BorderRadius.circular(10),

      child: Container(
        width: 34,
        height: 34,

        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.1),

          borderRadius:
              BorderRadius.circular(10),
        ),

        child: Icon(
          icon,
          size: 18,
          color: Theme.of(context)
              .colorScheme
              .primary,
        ),
      ),
    );
  }

  // ------------------------------------------------
  // CART SUMMARY
  // ------------------------------------------------

  Widget _buildCartSummary(
    BuildContext context,
    CartService cart,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        20,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Column(
          children: [

            // Number of items
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Items',
                ),

                Text(
                  '${cart.itemCount}',
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Subtotal
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Subtotal',
                ),

                Text(
                  'KSh ${cart.total.toStringAsFixed(2)}',
                ),
              ],
            ),

            const Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),

            // Total
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  'Total',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                ),

                Text(
                  'KSh ${cart.total.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Checkout button
            SizedBox(
              width: double.infinity,
              height: 54,

              child: ElevatedButton(
                onPressed: cart.isEmpty ? null : () {
                          if (!context.read<AuthService>().isLoggedIn) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Login Required"),
                                content: const Text(
                                  "Please log in to continue with checkout.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text("Login"),
                                  )
                                ] 
                              )
                            );
                          }else{
                            //TO DO: function to add order
                          final auth = Provider.of<AuthService>(
                            context,
                            listen: false,
                          );
                          final currentUser = auth.currentUser;
                          addOrder(cart.cart, currentUser);
                          }
                        }, //add function to checkout
                    

                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // EMPTY CART
  // ------------------------------------------------

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(
              width: 110,
              height: 110,

              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.1),

                shape: BoxShape.circle,
              ),

              child: Icon(
                Icons.shopping_cart_outlined,
                size: 55,
                color: Theme.of(context)
                    .colorScheme
                    .primary,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'Your cart is empty',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 10),

            Text(
              'Add some fresh produce to your cart and it will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

