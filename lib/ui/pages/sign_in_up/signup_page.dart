import 'package:flutter/material.dart';
import 'package:mavent/services/auth_service.dart';
import 'package:mavent/ui/pages/sign_in_up/login_page.dart';
import 'package:mavent/ui/widgets/custom_input_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Path ke logo aplikasi
                    height: 40, // Atur tinggi logo sesuai kebutuhan
                  ),
                  SizedBox(width: 10),
                  Text(
                    'MAVENT', // Ganti dengan nama aplikasi
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 8,
                      child: Container(
                          width: 100,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          alignment: AlignmentDirectional(0, -1),
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 280,
                                          child: Image.asset(
                                            'assets/images/login.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 36,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 12, 0, 24),
                                          child: Text(
                                            'Let\'s get started by filling out the form below.',
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        CustomInputForm(
                                            controller: _nameController,
                                            label: "Name",
                                            hint: "Enter your Name"),
                                        CustomInputForm(
                                            controller: _emailController,
                                            label: "Email",
                                            hint: "Enter your Email",
                                            autofillHints: [
                                              AutofillHints.email
                                            ]),
                                        CustomInputForm(
                                            obscureText: true,
                                            controller: _passwordController,
                                            label: "Password",
                                            hint: "Enter your Password"),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final user =
                                                await _authService.signUp(
                                              _emailController.text,
                                              _passwordController.text,
                                              _nameController.text,
                                            );
                                            if (user != null) {
                                              // Tampilkan pesan sukses pendaftaran
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Registration successful')),
                                              );
                                              // Secara opsional, Anda dapat membawa pengguna ke halaman login setelah mendaftar
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/login', // Ganti dengan nama rute untuk HomePage
                                                (route) =>
                                                    false, // Hapus semua halaman sebelumnya dari tumpukan navigasi
                                              );
                                            } else {
                                              // Tampilkan pesan kesalahan jika gagal mendaftar
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Failed to register. Please try again later')),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF4B39EF),
                                            minimumSize: Size(370, 44),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 3,
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 12, 0, 12),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                            ),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Already have an account? ',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
                                                      color: Color(0xFF101213),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' Login here ',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
                                                      color: Color(0xFF4B39EF),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]))))
                ],
              ),
            )));
  }
}
