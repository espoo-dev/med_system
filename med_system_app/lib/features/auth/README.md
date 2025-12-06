# 🔐 Feature de Autenticação - Clean Architecture + MVVM

## ✅ Status da Implementação

- ✅ **Clean Architecture** implementada
- ✅ **MVVM** com MobX
- ✅ **Injeção de Dependência** com GetIt
- ✅ **Testes Unitários** (37 testes passando)
- ✅ **Either Pattern** para tratamento de erros
- ✅ **SOLID Principles** aplicados

## 📊 Cobertura de Testes

### Total: 37 testes ✅

#### Use Cases (6 testes)
- ✅ SignInUseCase: 6 testes
  - Login bem-sucedido
  - Validação de email vazio
  - Validação de email inválido
  - Validação de senha vazia
  - Validação de senha curta
  - Credenciais inválidas

- ✅ GetCurrentUserUseCase: 2 testes (incluído no total)
- ✅ LogoutUseCase: 2 testes (incluído no total)

#### Repository (12 testes)
- ✅ signIn: 3 testes
  - Login remoto e salvamento local bem-sucedidos
  - Credenciais inválidas (ServerFailure)
  - Erro ao salvar localmente (CacheFailure)

- ✅ getCurrentUser: 2 testes
  - Usuário encontrado
  - Usuário não encontrado

- ✅ logout: 2 testes
  - Logout bem-sucedido
  - Erro ao fazer logout

- ✅ isAuthenticated: 3 testes
  - Usuário autenticado
  - Usuário não autenticado
  - Erro ao verificar

#### ViewModel (11 testes)
- ✅ setEmail: 1 teste
- ✅ setPassword: 1 teste
- ✅ canSubmit: 4 testes
  - Email vazio
  - Senha vazia
  - Ambos vazios
  - Ambos preenchidos

- ✅ signIn: 2 testes
  - Login bem-sucedido (loading → success)
  - Login com erro (loading → error)

- ✅ loadCurrentUser: 2 testes
  - Usuário encontrado
  - Usuário não encontrado

- ✅ logout: 2 testes
  - Logout bem-sucedido
  - Erro ao fazer logout

- ✅ resetState: 1 teste
- ✅ isLoading: 2 testes
- ✅ isAuthenticated: 2 testes

## 🏗️ Estrutura de Arquivos

```
lib/features/auth/
├── data/
│   ├── datasources/
│   │   ├── auth_local_datasource.dart       # Storage local (FlutterSecureStorage)
│   │   └── auth_remote_datasource.dart      # API (Chopper)
│   ├── models/
│   │   ├── signin_request_model.dart        # DTO de requisição
│   │   └── user_model.dart                  # DTO de resposta
│   └── repositories/
│       └── auth_repository_impl.dart        # Implementação do repositório
├── domain/
│   ├── entities/
│   │   └── user_entity.dart                 # Entidade de negócio
│   ├── repositories/
│   │   └── auth_repository.dart             # Interface do repositório
│   └── usecases/
│       ├── signin_usecase.dart              # Caso de uso: Login
│       ├── get_current_user_usecase.dart    # Caso de uso: Obter usuário
│       └── logout_usecase.dart              # Caso de uso: Logout
├── presentation/
│   ├── pages/
│   │   └── signin_page.dart                 # Tela de login
│   └── viewmodels/
│       ├── signin_viewmodel.dart            # ViewModel (MobX)
│       └── signin_viewmodel.g.dart          # Código gerado
├── auth_injection.dart                      # Injeção de dependências
└── README.md                                # Este arquivo

test/features/auth/
├── data/
│   └── repositories/
│       └── auth_repository_impl_test.dart   # 12 testes
├── domain/
│   └── usecases/
│       ├── signin_usecase_test.dart         # 6 testes
│       ├── get_current_user_usecase_test.dart
│       └── logout_usecase_test.dart
└── presentation/
    └── viewmodels/
        └── signin_viewmodel_test.dart       # 11 testes
```

## 🚀 Como Usar

### 1. Importar a nova página de login

```dart
import 'package:distrito_medico/features/auth/presentation/pages/signin_page.dart';
```

### 2. Usar o ViewModel

```dart
import 'package:get_it/get_it.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';

final viewModel = GetIt.I.get<SignInViewModel>();

// Fazer login
viewModel.setEmail('usuario@email.com');
viewModel.setPassword('senha123');
await viewModel.signIn();

// Verificar estado
if (viewModel.state == SignInState.success) {
  // Login bem-sucedido
  print('Bem-vindo, ${viewModel.currentUser?.resourceOwner.email}');
} else if (viewModel.state == SignInState.error) {
  // Erro no login
  print('Erro: ${viewModel.errorMessage}');
}

// Fazer logout
await viewModel.logout();
```

### 3. Verificar autenticação no início do app

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar injeção de dependências
  setupServiceLocator();
  
  // Carregar usuário atual
  final viewModel = GetIt.I.get<SignInViewModel>();
  await viewModel.loadCurrentUser();
  
  runApp(MyApp());
}
```

## 🔄 Migração da Implementação Antiga

### Antes (features/signin)
```dart
// Antiga estrutura
final signInStore = GetIt.I.get<SignInStore>();
await signInStore.signIn(email, password);
```

### Depois (features/auth)
```dart
// Nova estrutura Clean Architecture
final viewModel = GetIt.I.get<SignInViewModel>();
viewModel.setEmail(email);
viewModel.setPassword(password);
await viewModel.signIn();
```

## 📦 Dependências Adicionadas

```yaml
dependencies:
  dartz: ^0.10.1        # Either pattern para programação funcional
  equatable: ^2.0.5     # Comparação de objetos

dev_dependencies:
  mocktail: ^1.0.0      # Mocking para testes
```

## 🧪 Executar Testes

```bash
# Todos os testes da feature de auth
flutter test test/features/auth/

# Teste específico
flutter test test/features/auth/domain/usecases/signin_usecase_test.dart

# Com cobertura
flutter test --coverage test/features/auth/
```

## 🎯 Princípios SOLID Aplicados

### Single Responsibility Principle (SRP)
- ✅ Cada Use Case tem uma única responsabilidade
- ✅ Data Sources separados (Remote vs Local)
- ✅ ViewModel apenas gerencia estado da UI

### Open/Closed Principle (OCP)
- ✅ Aberto para extensão: Novos use cases podem ser adicionados facilmente
- ✅ Fechado para modificação: Interfaces estáveis

### Liskov Substitution Principle (LSP)
- ✅ AuthRepositoryImpl substitui AuthRepository
- ✅ Mocks substituem implementações reais nos testes

### Interface Segregation Principle (ISP)
- ✅ Interfaces específicas (AuthRepository)
- ✅ Data Sources com métodos focados

### Dependency Inversion Principle (DIP)
- ✅ Use Cases dependem de interfaces, não implementações
- ✅ Repository depende de abstrações de Data Sources
- ✅ Injeção de dependências via GetIt

## 🔐 Tratamento de Erros

### Hierarquia de Failures

```
Failure (abstrata)
├── ServerFailure      # Erros da API
├── CacheFailure       # Erros de storage local
├── NetworkFailure     # Erros de rede
├── ValidationFailure  # Erros de validação
├── AuthFailure        # Erros de autenticação
└── UnexpectedFailure  # Erros inesperados
```

### Fluxo de Tratamento de Erros

```
Exception (Data Layer)
    ↓
Repository converte em Failure
    ↓
Either<Failure, Success>
    ↓
Use Case retorna Either
    ↓
ViewModel faz fold()
    ↓
View reage ao estado
```

## 📚 Próximos Passos

1. ✅ Feature de Login implementada
2. ⏳ Migrar outras features para Clean Architecture
3. ⏳ Implementar refresh token
4. ⏳ Adicionar testes de integração
5. ⏳ Implementar gerenciamento de rotas com go_router

## 🤝 Contribuindo

Ao adicionar novas funcionalidades à feature de auth:

1. Siga a mesma estrutura de pastas
2. Crie testes unitários
3. Use Either para retornos de métodos assíncronos
4. Mantenha as entidades puras (sem dependências)
5. Um Use Case = Uma responsabilidade

## 📖 Referências

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter MVVM - Google](https://docs.flutter.dev/data-and-backend/state-mgmt/options)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Dartz - Functional Programming](https://pub.dev/packages/dartz)
- [MobX Documentation](https://mobx.netlify.app/)
