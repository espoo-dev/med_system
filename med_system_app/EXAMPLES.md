# 💡 Exemplos Práticos - Feature de Autenticação

## 📚 Índice
1. [Login Básico](#1-login-básico)
2. [Verificar Autenticação no Startup](#2-verificar-autenticação-no-startup)
3. [Logout](#3-logout)
4. [Navegação Condicional](#4-navegação-condicional)
5. [Tratamento de Erros](#5-tratamento-de-erros)
6. [Formulário com Validação](#6-formulário-com-validação)
7. [Loading States](#7-loading-states)
8. [Persistência de Sessão](#8-persistência-de-sessão)

---

## 1. Login Básico

### Exemplo Simples
```dart
import 'package:get_it/get_it.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';

void main() async {
  // Obter o ViewModel
  final viewModel = GetIt.I.get<SignInViewModel>();
  
  // Definir credenciais
  viewModel.setEmail('usuario@email.com');
  viewModel.setPassword('senha123');
  
  // Fazer login
  await viewModel.signIn();
  
  // Verificar resultado
  if (viewModel.state == SignInState.success) {
    print('Login bem-sucedido!');
    print('Usuário: ${viewModel.currentUser?.resourceOwner.email}');
  } else if (viewModel.state == SignInState.error) {
    print('Erro: ${viewModel.errorMessage}');
  }
}
```

### Com Widget
```dart
class LoginButton extends StatelessWidget {
  final viewModel = GetIt.I.get<SignInViewModel>();
  
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ElevatedButton(
          onPressed: viewModel.canSubmit
              ? () async {
                  await viewModel.signIn();
                }
              : null,
          child: viewModel.isLoading
              ? CircularProgressIndicator()
              : Text('Entrar'),
        );
      },
    );
  }
}
```

---

## 2. Verificar Autenticação no Startup

### main.dart
```dart
import 'package:flutter/material.dart';
import 'package:distrito_medico/core/di/service_locator.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:distrito_medico/features/auth/presentation/pages/signin_page.dart';
import 'package:distrito_medico/features/home/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar injeção de dependências
  setupServiceLocator();
  
  // Carregar usuário atual (se existir)
  final viewModel = GetIt.I.get<SignInViewModel>();
  await viewModel.loadCurrentUser();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.I.get<SignInViewModel>();
    
    return MaterialApp(
      title: 'Med System',
      home: Observer(
        builder: (_) {
          // Se autenticado, vai para Home, senão Login
          return viewModel.isAuthenticated
              ? HomePage()
              : SignInPage();
        },
      ),
    );
  }
}
```

### Com SplashScreen
```dart
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final viewModel = GetIt.I.get<SignInViewModel>();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await viewModel.loadCurrentUser();
    
    // Aguardar 2 segundos (splash)
    await Future.delayed(Duration(seconds: 2));
    
    // Navegar
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => viewModel.isAuthenticated
              ? HomePage()
              : SignInPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
```

---

## 3. Logout

### Logout Simples
```dart
class LogoutButton extends StatelessWidget {
  final viewModel = GetIt.I.get<SignInViewModel>();
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () async {
        await viewModel.logout();
        
        // Navegar para login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => SignInPage()),
          (route) => false,
        );
      },
    );
  }
}
```

### Com Confirmação
```dart
class LogoutButton extends StatelessWidget {
  final viewModel = GetIt.I.get<SignInViewModel>();
  
  Future<void> _confirmLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Logout'),
        content: Text('Deseja realmente sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Sair'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await viewModel.logout();
      
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => SignInPage()),
          (route) => false,
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () => _confirmLogout(context),
    );
  }
}
```

---

## 4. Navegação Condicional

### Com Reação (Recomendado)
```dart
class _SignInPageState extends State<SignInPage> {
  final viewModel = GetIt.I.get<SignInViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Reação para navegar automaticamente
    _disposers.add(
      reaction<SignInState>(
        (_) => viewModel.state,
        (state) {
          if (state == SignInState.success) {
            // Login bem-sucedido → Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          } else if (state == SignInState.error) {
            // Erro → Mostrar mensagem
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(viewModel.errorMessage)),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ... UI
  }
}
```

### Manualmente (Não Recomendado)
```dart
ElevatedButton(
  onPressed: () async {
    await viewModel.signIn();
    
    // Verificar manualmente
    if (viewModel.state == SignInState.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  },
  child: Text('Entrar'),
)
```

---

## 5. Tratamento de Erros

### Com Toast Personalizado
```dart
_disposers.add(
  reaction<SignInState>(
    (_) => viewModel.state,
    (state) {
      if (state == SignInState.error) {
        CustomToast.show(
          context,
          type: ToastType.error,
          title: "Erro ao fazer login",
          description: viewModel.errorMessage,
        );
      }
    },
  ),
);
```

### Com SnackBar
```dart
_disposers.add(
  reaction<SignInState>(
    (_) => viewModel.state,
    (state) {
      if (state == SignInState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(viewModel.errorMessage),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
      }
    },
  ),
);
```

### Com Dialog
```dart
_disposers.add(
  reaction<SignInState>(
    (_) => viewModel.state,
    (state) {
      if (state == SignInState.error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro'),
            content: Text(viewModel.errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    },
  ),
);
```

---

## 6. Formulário com Validação

### Formulário Completo
```dart
class SignInForm extends StatefulWidget {
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final viewModel = GetIt.I.get<SignInViewModel>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Campo de Email
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email é obrigatório';
              }
              if (!value.contains('@')) {
                return 'Email inválido';
              }
              return null;
            },
            onChanged: viewModel.setEmail,
          ),
          
          SizedBox(height: 16),
          
          // Campo de Senha
          Observer(
            builder: (_) {
              return TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  if (value.length < 4) {
                    return 'Senha deve ter no mínimo 4 caracteres';
                  }
                  return null;
                },
                onChanged: viewModel.setPassword,
              );
            },
          ),
          
          SizedBox(height: 24),
          
          // Botão de Login
          Observer(
            builder: (_) {
              return ElevatedButton(
                onPressed: viewModel.canSubmit && !viewModel.isLoading
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          await viewModel.signIn();
                        }
                      }
                    : null,
                child: viewModel.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text('Entrar'),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

---

## 7. Loading States

### Botão com Loading
```dart
Observer(
  builder: (_) {
    return ElevatedButton(
      onPressed: viewModel.isLoading ? null : () => viewModel.signIn(),
      child: viewModel.isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                Text('Entrando...'),
              ],
            )
          : Text('Entrar'),
    );
  },
)
```

### Overlay de Loading
```dart
Observer(
  builder: (_) {
    return Stack(
      children: [
        // Conteúdo normal
        YourContent(),
        
        // Overlay de loading
        if (viewModel.isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  },
)
```

---

## 8. Persistência de Sessão

### Verificar Token Expirado
```dart
class AuthGuard {
  final viewModel = GetIt.I.get<SignInViewModel>();
  
  Future<bool> isTokenValid() async {
    await viewModel.loadCurrentUser();
    
    if (!viewModel.isAuthenticated) {
      return false;
    }
    
    final user = viewModel.currentUser!;
    final expiresAt = DateTime.now().add(
      Duration(seconds: user.expiresIn),
    );
    
    return DateTime.now().isBefore(expiresAt);
  }
}
```

### Auto-Refresh (Conceito)
```dart
class AuthService {
  final viewModel = GetIt.I.get<SignInViewModel>();
  Timer? _refreshTimer;
  
  void startAutoRefresh() {
    _refreshTimer?.cancel();
    
    _refreshTimer = Timer.periodic(
      Duration(minutes: 50), // Refresh antes de expirar
      (_) async {
        if (viewModel.isAuthenticated) {
          // TODO: Implementar refresh token
          // await refreshToken();
        }
      },
    );
  }
  
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
  }
}
```

---

## 🎯 Dicas e Boas Práticas

### ✅ Faça
- Use `reaction` para navegação automática
- Valide dados no formulário antes de chamar `signIn()`
- Mostre feedback visual durante loading
- Trate todos os estados (idle, loading, success, error)
- Limpe `ReactionDisposer` no `dispose()`

### ❌ Evite
- Chamar `signIn()` sem validar os campos
- Navegar manualmente após `signIn()` (use `reaction`)
- Ignorar o estado de loading
- Deixar reações ativas após dispose
- Acessar `currentUser` sem verificar se é null

---

## 📚 Recursos Adicionais

- [README da Feature](../lib/features/auth/README.md)
- [Guia de Migração](../MIGRATION_GUIDE.md)
- [Resumo da Refatoração](../REFACTORING_SUMMARY.md)
- [Diagramas de Arquitetura](../ARCHITECTURE_DIAGRAM.md)
