import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/supabase_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final svc = Provider.of<SupabaseService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF012A3A), // dark blue background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Gradient Bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF3CBEC9), // light aqua
                        Color(0xFF0A7377), // darker teal
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Mancilla Store',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // Form container
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email Field
                      TextField(
                        controller: _emailCtrl,
                        decoration: InputDecoration(
                          prefixIcon:
                          const Icon(Icons.email, color: Color(0xFF0A7377)),
                          hintText: 'Email',
                          hintStyle:
                          GoogleFonts.poppins(color: Colors.grey[600]),
                          filled: true,
                          fillColor: const Color(0xFFF4FAFA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextField(
                        controller: _passCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFF0A7377)),
                          hintText: 'Password',
                          hintStyle:
                          GoogleFonts.poppins(color: Colors.grey[600]),
                          filled: true,
                          fillColor: const Color(0xFFF4FAFA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A7377),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _loading
                              ? null
                              : () async {
                            setState(() => _loading = true);
                            await svc.signIn(
                              _emailCtrl.text.trim(),
                              _passCtrl.text.trim(),
                            );
                            setState(() => _loading = false);

                            if (svc.error == null) {
                              Navigator.pushReplacementNamed(
                                  context, '/items');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(svc.error!),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                          child: _loading
                              ? const CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation(Colors.white),
                          )
                              : Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign Up link
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
