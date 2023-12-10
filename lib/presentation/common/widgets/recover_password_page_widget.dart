import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:unilunch/logic/Usuario.dart';
import 'package:unilunch/presentation/common/widgets/login_page_widget.dart';
import 'package:unilunch/alerts.dart';

class RecoverPasswordPageWidget extends StatefulWidget {
  @override
  _RecoverPasswordPageWidgetState createState() =>
      _RecoverPasswordPageWidgetState();
}

class _RecoverPasswordPageWidgetState extends State<RecoverPasswordPageWidget> {
  final TextEditingController emailController = TextEditingController();
  final unfocusNode = FocusNode();

  bool accountExists = true;
  Timer? _timer;
  // ignore: unused_field
  String? _userEmail;
  String? _verificationCode;
  DateTime? _codeCreationTime;

  Future<void> checkAccountExists(BuildContext context) async {
    String email = emailController.text;

    dynamic user = await Usuario.vacio().checkIfUserExists(email);

    if(user is Usuario){
      //print("Usuario existe");
      final userEmail = user.email;
      _verificationCode = _generateVerificationCode();
      _codeCreationTime = DateTime.now();
      _sendVerificationCode(userEmail, _verificationCode!);
      _startTimer();

      setState(() {
        _userEmail = userEmail;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodePage(
            userEmail: userEmail,
            verificationCode: _verificationCode!,
            codeCreationTime: _codeCreationTime!,
          ),
        ),
      );

    } else {
      setState(() {
        accountExists = false;
      });
    }
  }

  void _sendVerificationCode(String userEmail, String code) async {
    final smtpServer = gmail('unilunchapp@gmail.com', 'rpgmerzcrhuchnnu');

    final message = Message()
      ..from = Address('unilunchapp@gmail.com', 'SupportEmailSoftwareUni')
      ..recipients.add(userEmail)
      ..subject = 'UniLunch - Recuperación de Contraseña'
      ..text = '''
    ¡Hola!

    Hemos recibido una solicitud de restablecimiento de contraseña de tu cuenta en UniLunch. Tú código de verificación es el siguiente:

    $code

    Ingresa el código anterior en la app para continuar con tu proceso de restablecimiento.

    Sí no fuiste tú, por favor, ignora este mensaje.

    ¡Muchas gracias por tu confianza!

    Equipo de UniLunch
    ''';

    try {
      // ignore: unused_local_variable
      final sendReport = await send(message, smtpServer);
      print('Código de verificación enviado a $userEmail');
    } catch (e) {
      print('Error al enviar el correo electrónico: $e');
    }
  }

  String _generateVerificationCode() {
    final random = Random();
    final code = List.generate(6, (_) => random.nextInt(10)).join();
    return code;
  }

  void _startTimer() {
    const oneMinute = Duration(minutes: 1);
    _timer = Timer(oneMinute, _onTimerExpired);
  }

  void _onTimerExpired() {
    setState(() {
      _verificationCode = null;
      _codeCreationTime = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: Color(0xFFC6E8DA),
            automaticallyImplyLeading: false,
            title: Stack(
              alignment: AlignmentDirectional(0, 0),
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'Recuperar Contraseña',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF064244),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: FlutterFlowIconButton(
                    borderColor: Color(0x00FFFFFF),
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 40,
                    fillColor: Color(0x00FFFFFF),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFF064244),
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder:(context) => LoginPageWidget()));
                    },
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            elevation: 2,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Ingresa tu correo electrónico registrado y te enviaremos un código de verificación.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF064244),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.0),
      
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: emailController,
                      autofocus: true,
                      autofillHints: [AutofillHints.email],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF064244),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.of(context)
                            .secondaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            24, 24, 24, 24),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF064244),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF064244),
                          ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: FFButtonWidget(
                    onPressed: () {
                      checkAccountExists(context);
                    },
                    text: 'Enviar Código de Verificación',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width,
                      height: 52,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0xFF064244),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                          ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                if (!accountExists)
                  Text(
                    'No existe una cuenta con esta dirección de correo electrónico',
                    style: TextStyle(
                      color: Color(0xFFD31717),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationCodePage extends StatefulWidget {
  final String userEmail;
  final String verificationCode;
  final DateTime codeCreationTime;

  VerificationCodePage({
    required this.userEmail,
    required this.verificationCode,
    required this.codeCreationTime,
  });

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final unfocusNode = FocusNode();
  late bool passwordVisibility = false;
  List<TextEditingController> codeControllers = [];
  int codeLength = 6;
  bool _isCodeCorrect = false;
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeLength; i++) {
      codeControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < codeLength; i++) {
      codeControllers[i].dispose();
    }
    passwordController.dispose();
    super.dispose();
  }

  void _verifyCode() {
    String inputCode = "";
    for (int i = 0; i < codeLength; i++) {
      inputCode += codeControllers[i].text;
    }

    if (inputCode.isNotEmpty &&
        inputCode == widget.verificationCode &&
        !_isCodeExpired()) {
      setState(() {
        _isCodeCorrect = true;
      });
    } else {
      errorMessage(context, "El código de verificación ingresado no es válido o ha expirado.");
    }
  }

  bool _isCodeExpired() {
    const validDuration = Duration(minutes: 1);
    final now = DateTime.now();
    final codeExpirationTime = widget.codeCreationTime.add(validDuration);
    return now.isAfter(codeExpirationTime);
  }

  void _resetPassword() async {
    final newPassword = passwordController.text;

    if (newPassword.length < 5 || newPassword.length > 20) {
      errorMessage(context, "La contraseña debe tener entre 5 y 20 caracteres.");
      return;
    }

    final Usuario user = Usuario.vacio();

    dynamic passwordUpdated = await user.actualizarContrasena(newPassword, widget.userEmail);
    if (passwordUpdated == 1) {
      accceptPassRecoveryMessage(context, "Tu contraseña ha sido actualizada.");
    } else {
      errorMessage(context, "No se pudo restablecer la contraseña. Inténtalo nuevamente más tarde.");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: Color(0xFFC6E8DA),
            automaticallyImplyLeading: false,
            title: Stack(
              alignment: AlignmentDirectional(0, 0),
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'Código de Verificación',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF064244),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: FlutterFlowIconButton(
                    borderColor: Color(0x00FFFFFF),
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 40,
                    fillColor: Color(0x00FFFFFF),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFF064244),
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder:(context) => LoginPageWidget()));
                    },
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            elevation: 2,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 32.0),
                Icon(
                  CupertinoIcons.envelope_open_fill,
                  size: 50.0,
                  color: Color(0xFF3A9193),
                ),
                Text(
                  'Ingresa el código de verificación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF064244),
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Se ha enviado un código de verificación al correo electrónico asociado con tu cuenta.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF064244),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Correo electrónico: ${widget.userEmail}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF064244),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ingresa el código de 6 dígitos para verificar tu identidad.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF064244),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    codeLength,
                    (index) => Container(
                      width: 40.0,
                      child: TextFormField(
                        controller: codeControllers[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xFF064244)
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF064244),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < codeLength - 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                if (_isCodeCorrect)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: passwordController,
                            autofillHints: [AutofillHints.password],
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle:
                                  FlutterFlowTheme.of(context).labelMedium,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF064244),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  24, 24, 24, 24),
                              prefixIcon: Icon(
                                Icons.key_rounded,
                                color: Color(0xFF064244),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordVisibility =
                                      !passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFF064244),
                                  size: 24,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF064244),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: FFButtonWidget(
                            onPressed: () {
                              _resetPassword();
                            },
                            text: 'Restablecer Contraseña',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width,
                              height: 52,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Color(0xFF064244),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!_isCodeCorrect)
                  Container(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: FFButtonWidget(
                        onPressed: () {
                          _verifyCode();
                        },
                        text: 'Verificar Código',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width,
                          height: 52,
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF064244),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
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
