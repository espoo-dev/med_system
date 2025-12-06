# 🔄 Guia de Migração - Login (Antiga → Nova Arquitetura)

## 📋 Visão Geral

Este guia mostra como migrar do código antigo (`features/signin`) para a nova arquitetura Clean Architecture (`features/auth`).

## 🎯 O que mudou?

### Estrutura Antiga
```
features/signin/
├── model/
│   ├── signin_request.model.dart
│   └── user.model.dart
├── repository/
│   └── signin_repository.dart
├── store/
│   ├── signin.store.dart
│   └── signin.store.g.dart
└── page/
    └── signin.page.dart
```

### Nova Estrutura (Clean Architecture)
```
features/auth/
├── domain/              # Regras de negócio puras
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/               # Implementação de acesso a dados
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── presentation/       # UI e ViewModel
│   ├── pages/
│   └── viewmodels/
└── auth_injection.dart
```

## 🔧 Mudanças no Código

### 1. Importações

#### Antes
```dart
import 'package:distrito_medico/features/signin/store/signin.store.dart';
import 'package:distrito_medico/features/signin/model/user.model.dart';
```

#### Depois
```dart
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
```

### 2. Injeção de Dependência

#### Antes
```dart
final signInStore = GetIt.I.get<SignInStore>();
```

#### Depois
```dart
final viewModel = GetIt.I.get<SignInViewModel>();
```

### 3. Fazer Login

#### Antes
```dart
await signInStore.signIn(email, password);

if (signInStore.signInState == SignInState.success) {
  // Sucesso
} else if (signInStore.signInState == SignInState.error) {
  // Erro: signInStore.errorMessage
}
```

#### Depois
```dart
viewModel.setEmail(email);
viewModel.setPassword(password);
await viewModel.signIn();

if (viewModel.state == SignInState.success) {
  // Sucesso
} else if (viewModel.state == SignInState.error) {
  // Erro: viewModel.errorMessage
}
```

### 4. Obter Usuário Atual

#### Antes
```dart
final user = await signInStore.getUserStorage();
```

#### Depois
```dart
await viewModel.loadCurrentUser();
final user = viewModel.currentUser;
```

### 5. Verificar Autenticação

#### Antes
```dart
if (signInStore.isAuthenticated) {
  // Usuário autenticado
}
```

#### Depois
```dart
if (viewModel.isAuthenticated) {
  // Usuário autenticado
}
```

### 6. Fazer Logout

#### Antes
```dart
await signInStore.forceLogout();
```

#### Depois
```dart
await viewModel.logout();
```

### 7. Observar Mudanças de Estado

#### Antes
```dart
Observer(builder: (_) {
  return MyButton(
    isLoading: signInStore.signInState == SignInState.loading,
    onTap: () => signInStore.signIn(email, password),
  );
})
```

#### Depois
```dart
Observer(builder: (_) {
  return MyButton(
    isLoading: viewModel.isLoading,
    onTap: () => viewModel.signIn(),
  );
})
```

### 8. Reações (Navegação após login)

#### Antes
```dart
_disposers.add(
  reaction<SignInState>(
    (_) => signInStore.signInState,
    (state) {
      if (state == SignInState.success) {
        to(context, const HomePage());
      }
    },
  ),
);
```

#### Depois
```dart
_disposers.add(
  reaction<SignInState>(
    (_) => viewModel.state,
    (state) {
      if (state == SignInState.success) {
        to(context, const HomePage());
      }
    },
  ),
);
```

## 📝 Checklist de Migração

### Passo 1: Atualizar Dependências
- [x] Adicionar `dartz` no pubspec.yaml
- [x] Adicionar `equatable` no pubspec.yaml
- [x] Adicionar `mocktail` nas dev_dependencies
- [x] Executar `flutter pub get`

### Passo 2: Atualizar Importações
- [ ] Substituir imports de `features/signin` por `features/auth`
- [ ] Atualizar referências a `SignInStore` para `SignInViewModel`
- [ ] Atualizar referências a `UserModel` para `UserEntity`

### Passo 3: Atualizar Código
- [ ] Substituir `GetIt.I.get<SignInStore>()` por `GetIt.I.get<SignInViewModel>()`
- [ ] Atualizar chamadas de métodos conforme tabela acima
- [ ] Atualizar observações de estado

### Passo 4: Testar
- [ ] Executar testes: `flutter test test/features/auth/`
- [ ] Testar login manualmente
- [ ] Testar logout manualmente
- [ ] Verificar persistência de sessão

### Passo 5: Limpar Código Antigo (Opcional)
- [ ] Remover ou deprecar `features/signin` (manter por enquanto para referência)
- [ ] Atualizar documentação

## 🎨 Exemplo Completo de Migração

### Antes: signin.page.dart (Antigo)
```dart
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInStore = GetIt.I.get<SignInStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers.add(
      reaction<SignInState>(
        (_) => signInStore.signInState,
        (state) {
          if (state == SignInState.success) {
            to(context, const HomePage());
          } else if (state == SignInState.error) {
            CustomToast.show(context,
                type: ToastType.error,
                title: "Erro ao tentar realizar o login",
                description: signInStore.errorMessage);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextFormField(
              label: 'E-mail',
              onChanged: signInStore.changeEmail,
            ),
            MyTextFormFieldPassword(
              label: 'Senha',
              onChanged: signInStore.changePassword,
            ),
            Observer(builder: (_) {
              return MyButtonWidget(
                text: 'Entrar',
                isLoading: signInStore.signInState == SignInState.loading,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await signInStore.signIn(
                      signInStore.email,
                      signInStore.password,
                    );
                  }
                },
              );
            }),
          ],
        ),
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
}
```

### Depois: signin_page.dart (Novo)
```dart
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final viewModel = GetIt.I.get<SignInViewModel>();  // ✅ Mudança aqui
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _disposers.add(
      reaction<SignInState>(
        (_) => viewModel.state,  // ✅ Mudança aqui
        (state) {
          if (state == SignInState.success) {
            to(context, const HomePage());
          } else if (state == SignInState.error) {
            CustomToast.show(context,
                type: ToastType.error,
                title: "Erro ao tentar realizar o login",
                description: viewModel.errorMessage);  // ✅ Mudança aqui
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextFormField(
              label: 'E-mail',
              onChanged: viewModel.setEmail,  // ✅ Mudança aqui
            ),
            MyTextFormFieldPassword(
              label: 'Senha',
              onChanged: viewModel.setPassword,  // ✅ Mudança aqui
            ),
            Observer(builder: (_) {
              return MyButtonWidget(
                text: 'Entrar',
                isLoading: viewModel.isLoading,  // ✅ Mudança aqui
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await viewModel.signIn();  // ✅ Mudança aqui
                  }
                },
              );
            }),
          ],
        ),
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
}
```

## 🔍 Principais Diferenças

| Aspecto | Antiga | Nova |
|---------|--------|------|
| **Nomenclatura** | `SignInStore` | `SignInViewModel` |
| **Métodos** | `changeEmail()`, `changePassword()` | `setEmail()`, `setPassword()` |
| **Estado** | `signInState` | `state` |
| **Login** | `signIn(email, password)` | `setEmail()`, `setPassword()`, `signIn()` |
| **Usuário** | `currentUser` (nullable) | `currentUser` (nullable) |
| **Autenticado** | `isAuthenticated` | `isAuthenticated` |
| **Logout** | `forceLogout()` | `logout()` |
| **Carregar usuário** | `getUserStorage()` | `loadCurrentUser()` |

## ✅ Vantagens da Nova Arquitetura

1. **Testabilidade**: 37 testes unitários cobrindo toda a lógica
2. **Separação de Responsabilidades**: Domain, Data e Presentation bem definidos
3. **Manutenibilidade**: Código mais organizado e fácil de entender
4. **Escalabilidade**: Fácil adicionar novas features seguindo o mesmo padrão
5. **Type Safety**: Uso de Either elimina exceções não tratadas
6. **SOLID**: Todos os princípios SOLID aplicados

## 🚀 Próximos Passos

1. Migrar outras telas que usam `SignInStore` para `SignInViewModel`
2. Testar todas as funcionalidades
3. Remover código antigo após validação completa
4. Documentar outras features seguindo o mesmo padrão

## 📚 Recursos

- [README da Feature Auth](./README.md)
- [ARCHITECTURE_DIAGRAM.md](../../ARCHITECTURE_DIAGRAM.md)
- [PRACTICAL_GUIDE.md](../../PRACTICAL_GUIDE.md)
