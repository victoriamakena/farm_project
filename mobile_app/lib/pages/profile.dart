import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'login.dart';
import 'orders.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    final user = auth.currentUser;

    // User is NOT logged in
    if (user == null) {
      return _buildLoggedOutProfile(context);
    }

    // User IS logged in
    return _buildLoggedInProfile(
      context,
      auth,
      user,
    );
  }

  // --------------------------------------------------
  // LOGGED OUT VIEW
  // --------------------------------------------------

  Widget _buildLoggedOutProfile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Profile icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 55,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'You are not logged in',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 10),

              Text(
                'Login to view your profile, orders and account details.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.login,
                  ),

                  label: const Text(
                    'Login',
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
      ),
    );
  }

  // --------------------------------------------------
  // LOGGED IN VIEW
  // --------------------------------------------------

  Widget _buildLoggedInProfile(
    BuildContext context,
    AuthService auth,
    dynamic user,
  ) {
    final fullName =
        '${user.firstName} ${user.lastName}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ------------------------------------------
            // PROFILE HEADER
            // ------------------------------------------

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [

                    Container(
                      width: 70,
                      height: 70,

                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),

                        shape: BoxShape.circle,
                      ),

                      child: Icon(
                        Icons.person,
                        size: 38,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            fullName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            user.email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------
            // ACCOUNT DETAILS
            // ------------------------------------------

            Text(
              'Account Details',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Column(
                children: [

                  _profileItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'Full Name',
                    value: fullName,
                  ),

                  const Divider(
                    height: 1,
                  ),

                  _profileItem(
                    context,
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: user.email,
                  ),

                  const Divider(
                    height: 1,
                  ),

                  _profileItem(
                    context,
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: user.phone,
                  ),

                  const Divider(
                    height: 1,
                  ),

                  _profileItem(
                    context,
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: user.location,
                  ),

                  const Divider(
                    height: 1,
                  ),

                  _profileItem(
                    context,
                    icon: Icons.home_outlined,
                    title: 'Delivery Address',
                    value: user.address,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------
            // MY ORDERS
            // ------------------------------------------

            Text(
              'Orders',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),

                leading: Container(
                  width: 45,
                  height: 45,

                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.1),

                    borderRadius:
                        BorderRadius.circular(14),
                  ),

                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Theme.of(context)
                        .colorScheme
                        .primary,
                  ),
                ),

                title: const Text(
                  'My Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                subtitle: const Text(
                  'View your previous orders',
                ),

                trailing: const Icon(
                  Icons.chevron_right,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const OrdersPage(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------
            // LOGOUT
            // ------------------------------------------

            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(
                    context,
                    auth,
                  );
                },

                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // PROFILE ITEM
  // --------------------------------------------------

  Widget _profileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: Theme.of(context)
                .colorScheme
                .primary,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // LOGOUT DIALOG
  // --------------------------------------------------

  void _showLogoutDialog(
    BuildContext context,
    AuthService auth,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Logout',
          ),

          content: const Text(
            'Are you sure you want to logout?',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                context.read<AuthService>().logout();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginPage(),
                  ),
                  (route) => false,
                );
              },

              child: const Text(
                'Logout',
              ),
            ),
          ],
        );
      },
    );
  }
}