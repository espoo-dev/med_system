# Documentação do Projeto

[![codecov](https://codecov.io/gh/espoo-dev/med_system/branch/main/graph/badge.svg)](https://codecov.io/gh/espoo-dev/med_system)


## Diagrama da Arquitetura - Feature de Autenticação

## 📐 Visão Geral da Clean Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                        │
│                     (UI + ViewModel + State)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────────┐         ┌──────────────────────────┐      │
│  │  SignInPage      │────────▶│  SignInViewModel         │      │
│  │  (View/UI)       │         │  (MobX)                  │      │
│  └──────────────────┘         │                          │      │
│         │                      │  - email                 │      │
│         │ observa              │  - password              │      │
│         │                      │  - state                 │      │
│         ▼                      │  - currentUser           │      │
│  ┌──────────────────┐         │  - isAuthenticated       │      │
│  │  Observer        │         │                          │      │
│  │  (MobX)          │         │  + signIn()              │      │
│  └──────────────────┘         │  + loadCurrentUser()     │      │
│                                │  + logout()              │      │
│                                └────────┬─────────────────┘      │
│                                         │                        │
26: └─────────────────────────────────────────┼────────────────────────┘
                                          │ chama
                                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                         DOMAIN LAYER                             │
│                   (Regras de Negócio Puras)                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                    Use Cases                          │       │
│  ├──────────────────────────────────────────────────────┤       │
│  │                                                        │       │
│  │  ┌─────────────────────┐  ┌──────────────────────┐  │       │
│  │  │ SignInUseCase       │  │ GetCurrentUserUseCase│  │       │
│  │  │                     │  │                      │  │       │
│  │  │ + call(params)      │  │ + call(NoParams)     │  │       │
│  │  │   - Valida email    │  │   - Obtém usuário    │  │       │
│  │  │   - Valida senha    │  │     do storage       │  │       │
│  │  │   - Chama repo      │  │                      │  │       │
│  │  └─────────┬───────────┘  └──────────┬───────────┘  │       │
│  │            │                          │              │       │
│  │            │  ┌──────────────────┐   │              │       │
│  │            │  │ LogoutUseCase    │   │              │       │
│  │            │  │                  │   │              │       │
│  │            │  │ + call(NoParams) │   │              │       │
│  │            │  │   - Limpa dados  │   │              │       │
│  │            │  └────────┬─────────┘   │              │       │
│  │            │            │             │              │       │
│  └────────────┼────────────┼─────────────┼──────────────┘       │
│               │            │             │                      │
│               └────────────┴─────────────┘                      │
│                            │                                    │
│                            │ usa                                │
│                            ▼                                    │
│  ┌──────────────────────────────────────────────────────┐      │
│  │          AuthRepository (Interface)                   │      │
│  ├──────────────────────────────────────────────────────┤      │
│  │  + signIn(email, password): Either<Failure, User>    │      │
│  │  + getCurrentUser(): Either<Failure, User>           │      │
│  │  + logout(): Either<Failure, Unit>                   │      │
│  │  + isAuthenticated(): bool                           │      │
│  └──────────────────────────────────────────────────────┘      │
│                            ▲                                    │
│                            │ implementa                         │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                  Entities                             │      │
│  ├──────────────────────────────────────────────────────┤      │
│  │  UserEntity                                           │      │
│  │  - token: String                                      │      │
│  │  - refreshToken: String                               │      │
│  │  - expiresIn: int                                     │      │
│  │  - tokenType: String                                  │      │
│  │  - resourceOwner: ResourceOwner                       │      │
│  └──────────────────────────────────────────────────────┘      │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
                                          │
                                          │
┌─────────────────────────────────────────┼────────────────────────┐
│                         DATA LAYER                               │
│              (Implementação de Acesso a Dados)                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────────────────────────────────────────────┐       │
│  │        AuthRepositoryImpl                             │       │
│  ├──────────────────────────────────────────────────────┤       │
│  │  - remoteDataSource: AuthRemoteDataSource            │       │
│  │  - localDataSource: AuthLocalDataSource              │       │
│  │                                                        │       │
│  │  + signIn(email, password)                            │       │
│  │    1. Chama remoteDataSource.signIn()                │       │
│  │    2. Salva via localDataSource.saveUser()           │       │
│  │    3. Converte Model → Entity                        │       │
│  │    4. Trata exceções → Failures                      │       │
│  │                                                        │       │
│  │  + getCurrentUser()                                   │       │
│  │    1. Chama localDataSource.getUser()                │       │
│  │    2. Converte Model → Entity                        │       │
│  │                                                        │       │
│  │  + logout()                                           │       │
│  │    1. Chama localDataSource.clearUser()              │       │
│  └────────────────┬──────────────┬──────────────────────┘       │
│                   │              │                              │
│                   ▼              ▼                              │
│  ┌─────────────────────┐  ┌──────────────────────┐            │
│  │ AuthRemoteDataSource│  │ AuthLocalDataSource  │            │
│  │ (Interface)         │  │ (Interface)          │            │
│  └─────────┬───────────┘  └──────────┬───────────┘            │
│            │                          │                        │
│            ▼                          ▼                        │
│  ┌─────────────────────┐  ┌──────────────────────┐            │
│  │ AuthRemoteDataSource│  │ AuthLocalDataSource  │            │
│  │ Impl                │  │ Impl                 │            │
│  ├─────────────────────┤  ├──────────────────────┤            │
│  │ + signIn()          │  │ + saveUser()         │            │
│  │   - Usa Chopper     │  │   - Usa Secure       │            │
│  │   - Chama API       │  │     Storage          │            │
│  │   - Retorna Model   │  │ + getUser()          │            │
│  │                     │  │ + clearUser()        │            │
│  │                     │  │ + hasUser()          │            │
│  └─────────┬───────────┘  └──────────┬───────────┘            │
│            │                          │                        │
│            ▼                          ▼                        │
│  ┌─────────────────────┐  ┌──────────────────────┐            │
│  │    Models (DTOs)    │  │  FlutterSecure       │            │
│  ├─────────────────────┤  │  Storage             │            │
│  │ UserModel           │  │                      │            │
│  │ - fromJson()        │  │  (Framework)         │            │
│  │ - toJson()          │  │                      │            │
│  │ - toEntity()        │  │                      │            │
│  │                     │  │                      │            │
│  │ SignInRequestModel  │  │                      │            │
│  │ - toJson()          │  │                      │            │
│  └─────────────────────┘  └──────────────────────┘            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🔄 Fluxo de Dados - Login

```
┌──────────┐
│  Usuário │
│  digita  │
│ credenci │
│   ais    │
└────┬─────┘
     │
     ▼
┌─────────────────────────┐
│   SignInPage            │
│   (View)                │
│                         │
│   1. Valida formulário  │
│   2. Chama viewModel    │
│      .signIn()          │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│   SignInViewModel       │
│   (Presentation)        │
│                         │
│   1. Muda estado para   │
│      loading            │
│   2. Chama SignInUseCase│
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│   SignInUseCase         │
│   (Domain)              │
│                         │
│   1. Valida email       │
│   2. Valida senha       │
│   3. Chama repository   │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  AuthRepositoryImpl     │
│  (Data)                 │
│                         │
│  1. Chama remote DS     │
│  2. Salva local DS      │
│  3. Converte Model→     │
│     Entity              │
│  4. Retorna Either      │
└────────┬────────────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌────────┐ ┌────────┐
│ Remote │ │ Local  │
│   DS   │ │   DS   │
│        │ │        │
│  API   │ │Storage │
└────────┘ └────────┘
    │         │
    └────┬────┘
         │
         ▼
┌─────────────────────────┐
│   Either<Failure, User> │
│                         │
│   Success: Right(User)  │
│   Error: Left(Failure)  │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│   SignInViewModel       │
│                         │
│   fold(                 │
│     error → state.error │
│     user → state.success│
│   )                     │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│   SignInPage            │
│                         │
│   reaction() observa    │
│   mudança de estado     │
│                         │
│   success → navega home │
│   error → mostra toast  │
└─────────────────────────┘
```

## 🧪 Pirâmide de Testes

```
                    ▲
                   ╱ ╲
                  ╱   ╲
                 ╱  E2E ╲
                ╱ Tests  ╲
               ╱───────────╲
              ╱             ╲
             ╱  Integration  ╲
            ╱     Tests       ╲
           ╱─────────────────── ╲
          ╱                      ╲
         ╱      Unit Tests        ╲
        ╱      (25 testes)         ╲
       ╱────────────────────────────╲
      ╱                              ╲
     ╱  • UseCase Tests (5)           ╲
    ╱   • Repository Tests (9)         ╲
   ╱    • ViewModel Tests (11)          ╲
  ╱──────────────────────────────────────╲
```

### Distribuição dos Testes

- **Use Cases** (5 testes)
  - ✅ Login bem-sucedido
  - ✅ Validação de email
  - ✅ Validação de senha
  - ✅ Senha curta
  - ✅ Credenciais inválidas

- **Repository** (9 testes)
  - ✅ Login remoto sucesso
  - ✅ Credenciais inválidas
  - ✅ Erro ao salvar localmente
  - ✅ Obter usuário atual
  - ✅ Usuário não encontrado
  - ✅ Logout sucesso
  - ✅ Erro ao fazer logout
  - ✅ Verificar autenticação (3 cenários)

- **ViewModel** (11 testes)
  - ✅ Atualizar email
  - ✅ Atualizar senha
  - ✅ Validação canSubmit (4 cenários)
  - ✅ Login (loading → success)
  - ✅ Login (loading → error)
  - ✅ Carregar usuário atual (2 cenários)
  - ✅ Logout (2 cenários)
  - ✅ Reset de estado

## 🎯 Princípios SOLID Aplicados

```
┌─────────────────────────────────────────────────────────┐
│  S - Single Responsibility Principle                    │
├─────────────────────────────────────────────────────────┤
│  ✅ Cada Use Case tem uma única responsabilidade        │
│  ✅ Data Sources separados (Remote vs Local)            │
│  ✅ ViewModel apenas gerencia estado da UI              │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  O - Open/Closed Principle                              │
├─────────────────────────────────────────────────────────┤
│  ✅ Aberto para extensão: Novos use cases facilmente    │
│  ✅ Fechado para modificação: Interfaces estáveis       │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  L - Liskov Substitution Principle                      │
├─────────────────────────────────────────────────────────┤
│  ✅ AuthRepositoryImpl substitui AuthRepository         │
│  ✅ Mocks substituem implementações reais nos testes    │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  I - Interface Segregation Principle                    │
├─────────────────────────────────────────────────────────┤
│  ✅ Interfaces específicas (AuthRepository)             │
│  ✅ Data Sources com métodos focados                    │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  D - Dependency Inversion Principle                     │
├─────────────────────────────────────────────────────────┤
│  ✅ Use Cases dependem de interfaces, não implementações│
│  ✅ Repository depende de abstrações de Data Sources    │
│  ✅ Injeção de dependências via GetIt                   │
└─────────────────────────────────────────────────────────┘
```

## 📦 Injeção de Dependências

```
setupServiceLocator()
    │
    └──▶ setupAuthInjection(getIt)
            │
            ├──▶ FlutterSecureStorage (Singleton)
            │
            ├──▶ AuthLocalDataSource (Lazy Singleton)
            │     └── depende de FlutterSecureStorage
            │
            ├──▶ AuthRemoteDataSource (Lazy Singleton)
            │
            ├──▶ AuthRepository (Lazy Singleton)
            │     ├── depende de AuthRemoteDataSource
            │     └── depende de AuthLocalDataSource
            │
            ├──▶ SignInUseCase (Lazy Singleton)
            │     └── depende de AuthRepository
            │
            ├──▶ GetCurrentUserUseCase (Lazy Singleton)
            │     └── depende de AuthRepository
            │
            ├──▶ LogoutUseCase (Lazy Singleton)
            │     └── depende de AuthRepository
            │
            └──▶ SignInViewModel (Lazy Singleton)
                  ├── depende de SignInUseCase
                  ├── depende de GetCurrentUserUseCase
                  └── depende de LogoutUseCase
```

## 🔐 Tratamento de Erros

```
Exception/Error
    │
    ▼
┌─────────────────────┐
│  Data Sources       │
│  lançam Exceptions  │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Repository         │
│  captura Exceptions │
│  converte em        │
│  Failures           │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Either             │
│  <Failure, Success> │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Use Case           │
│  retorna Either     │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  ViewModel          │
│  fold() para tratar │
│  Left (erro) ou     │
│  Right (sucesso)    │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  View               │
│  reage ao estado    │
│  mostra UI          │
└─────────────────────┘
```

---

# Guia Prático - Como Usar a Nova Arquitetura

## 🚀 Início Rápido

### 1. Usando o ViewModel na UI

```dart
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:distrito_medico/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MyLoginPage extends StatefulWidget {
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Injetar o ViewModel
  final viewModel = GetIt.I.get<SignInViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Campo de Email
          TextField(
            onChanged: viewModel.setEmail,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          
          // Campo de Senha
          TextField(
            onChanged: viewModel.setPassword,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Senha'),
          ),
          
          // Botão de Login com estado reativo
          Observer(
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
          ),
        ],
      ),
    );
  }
}
```

### 2. Reagindo a Mudanças de Estado

```dart
import 'package:mobx/mobx.dart';

class _MyLoginPageState extends State<MyLoginPage> {
  final viewModel = GetIt.I.get<SignInViewModel>();
  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Reação para navegar quando login for bem-sucedido
    _disposers.add(
      reaction<SignInState>(
        (_) => viewModel.state,
        (state) {
          if (state == SignInState.success) {
            // Navegar para home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          } else if (state == SignInState.error) {
            // Mostrar erro
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
    // Limpar reações
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }
}
```

### 3. Verificando Autenticação no Início do App

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.I.get<SignInViewModel>();
    
    return MaterialApp(
      home: Observer(
        builder: (_) {
          // Mostrar home se autenticado, senão login
          return viewModel.isAuthenticated
              ? HomePage()
              : SignInPage();
        },
      ),
    );
  }
}
```

### 4. Implementando Logout

```dart
class ProfilePage extends StatelessWidget {
  final viewModel = GetIt.I.get<SignInViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
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
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final user = viewModel.currentUser;
          
          if (user == null) {
            return Center(child: Text('Não autenticado'));
          }
          
          return Column(
            children: [
              Text('Email: ${user.resourceOwner.email}'),
              Text('ID: ${user.resourceOwner.id}'),
            ],
          );
        },
      ),
    );
  }
}
```

## 🧪 Escrevendo Testes

### 1. Teste de Use Case

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MyUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = MyUseCase(mockRepository);
  });

  test('deve retornar sucesso quando...', () async {
    // Arrange
    when(() => mockRepository.someMethod())
        .thenAnswer((_) async => Right(expectedResult));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Right(expectedResult));
    verify(() => mockRepository.someMethod()).called(1);
  });
}
```

### 2. Teste de Repository

```dart
void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDS;
  late MockLocalDataSource mockLocalDS;

  setUp(() {
    mockRemoteDS = MockRemoteDataSource();
    mockLocalDS = MockLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDS,
      localDataSource: mockLocalDS,
    );
  });

  test('deve salvar usuário localmente após login', () async {
    // Arrange
    when(() => mockRemoteDS.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => userModel);
    
    when(() => mockLocalDS.saveUser(any()))
        .thenAnswer((_) async => {});

    // Act
    await repository.signIn(email: 'test@test.com', password: '1234');

    // Assert
    verify(() => mockLocalDS.saveUser(userModel)).called(1);
  });
}
```

### 3. Teste de ViewModel

```dart
void main() {
  late SignInViewModel viewModel;
  late MockSignInUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSignInUseCase();
    viewModel = SignInViewModel(
      signInUseCase: mockUseCase,
      // ... outros use cases
    );
  });

  test('deve mudar estado para loading ao fazer login', () async {
    // Arrange
    viewModel.setEmail('test@test.com');
    viewModel.setPassword('1234');
    
    when(() => mockUseCase(any()))
        .thenAnswer((_) async => Right(userEntity));

    // Act
    final future = viewModel.signIn();

    // Assert - Estado loading
    expect(viewModel.state, SignInState.loading);
    expect(viewModel.isLoading, true);

    await future;

    // Assert - Estado success
    expect(viewModel.state, SignInState.success);
  });
}
```

## 🔧 Criando uma Nova Feature

### Passo 1: Estrutura de Pastas

```bash
lib/features/minha_feature/
├── data/
│   ├── datasources/
│   │   ├── minha_feature_local_datasource.dart
│   │   └── minha_feature_remote_datasource.dart
│   ├── models/
│   │   └── minha_model.dart
│   └── repositories/
│       └── minha_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── minha_entity.dart
│   ├── repositories/
│   │   └── minha_repository.dart
│   └── usecases/
│       └── meu_usecase.dart
├── presentation/
│   ├── pages/
│   │   └── minha_page.dart
│   └── viewmodels/
│       └── meu_viewmodel.dart
└── minha_feature_injection.dart
```

### Passo 2: Domain Layer

```dart
// 1. Criar Entity
class MinhaEntity extends Equatable {
  final String id;
  final String nome;

  const MinhaEntity({required this.id, required this.nome});

  @override
  List<Object?> get props => [id, nome];
}

// 2. Criar Repository Interface
abstract class MinhaRepository {
  Future<Either<Failure, MinhaEntity>> buscar(String id);
  Future<Either<Failure, List<MinhaEntity>>> listar();
  Future<Either<Failure, Unit>> salvar(MinhaEntity entity);
}

// 3. Criar Use Case
class BuscarUseCase implements UseCase<MinhaEntity, String> {
  final MinhaRepository repository;

  BuscarUseCase(this.repository);

  @override
  Future<Either<Failure, MinhaEntity>> call(String id) async {
    if (id.isEmpty) {
      return const Left(ValidationFailure(message: 'ID não pode ser vazio'));
    }
    return await repository.buscar(id);
  }
}
```

### Passo 3: Data Layer

```dart
// 1. Criar Model
class MinhaModel extends MinhaEntity {
  const MinhaModel({required super.id, required super.nome});

  factory MinhaModel.fromJson(Map<String, dynamic> json) {
    return MinhaModel(
      id: json['id'] as String,
      nome: json['nome'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome};
  }

  MinhaEntity toEntity() {
    return MinhaEntity(id: id, nome: nome);
  }
}

// 2. Criar Remote Data Source
abstract class MinhaRemoteDataSource {
  Future<MinhaModel> buscar(String id);
}

class MinhaRemoteDataSourceImpl implements MinhaRemoteDataSource {
  @override
  Future<MinhaModel> buscar(String id) async {
    try {
      final response = await minhaService.buscar(id);
      if (response.isSuccessful) {
        return MinhaModel.fromJson(json.decode(response.body));
      }
      throw ServerException(message: 'Erro ao buscar');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

// 3. Criar Repository Implementation
class MinhaRepositoryImpl implements MinhaRepository {
  final MinhaRemoteDataSource remoteDataSource;

  MinhaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MinhaEntity>> buscar(String id) async {
    try {
      final model = await remoteDataSource.buscar(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
```

### Passo 4: Presentation Layer

```dart
// 1. Criar ViewModel
class MeuViewModel = _MeuViewModelBase with _$MeuViewModel;

abstract class _MeuViewModelBase with Store {
  final BuscarUseCase buscarUseCase;

  _MeuViewModelBase({required this.buscarUseCase});

  @observable
  MinhaEntity? item;

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> buscar(String id) async {
    isLoading = true;
    errorMessage = '';

    final result = await buscarUseCase(id);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        isLoading = false;
      },
      (entity) {
        item = entity;
        isLoading = false;
      },
    );
  }
}

// 2. Criar Page
class MinhaPage extends StatelessWidget {
  final viewModel = GetIt.I.get<MeuViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (viewModel.isLoading) {
            return CircularProgressIndicator();
          }

          if (viewModel.errorMessage.isNotEmpty) {
            return Text('Erro: ${viewModel.errorMessage}');
          }

          final item = viewModel.item;
          if (item == null) {
            return Text('Nenhum item');
          }

          return Text('Nome: ${item.nome}');
        },
      ),
    );
  }
}
```

### Passo 5: Injeção de Dependências

```dart
void setupMinhaFeatureInjection(GetIt getIt) {
  // Data Sources
  getIt.registerLazySingleton<MinhaRemoteDataSource>(
    () => MinhaRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<MinhaRepository>(
    () => MinhaRepositoryImpl(
      remoteDataSource: getIt<MinhaRemoteDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => BuscarUseCase(getIt<MinhaRepository>()),
  );

  // ViewModels
  getIt.registerLazySingleton(
    () => MeuViewModel(
      buscarUseCase: getIt<BuscarUseCase>(),
    ),
  );
}

// No service_locator.dart
void setupServiceLocator() {
  // ... outras configurações
  
  setupMinhaFeatureInjection(getIt);
}
```

## 💡 Dicas e Boas Práticas

### 1. Sempre use Either para retornos de métodos assíncronos

```dart
// ❌ Evite
Future<User> getUser();

// ✅ Prefira
Future<Either<Failure, User>> getUser();
```

### 2. Mantenha as Entities puras (sem dependências)

```dart
// ❌ Evite
class User {
  final String id;
  
  Future<void> save() {
    // Lógica de persistência
  }
}

// ✅ Prefira
class User extends Equatable {
  final String id;
  
  const User({required this.id});
  
  @override
  List<Object?> get props => [id];
}
```

### 3. Um Use Case = Uma Responsabilidade

```dart
// ❌ Evite
class UserUseCase {
  Future<Either<Failure, User>> signIn();
  Future<Either<Failure, User>> signUp();
  Future<Either<Failure, Unit>> logout();
}

// ✅ Prefira
class SignInUseCase {
  Future<Either<Failure, User>> call(SignInParams params);
}

class SignUpUseCase {
  Future<Either<Failure, User>> call(SignUpParams params);
}

class LogoutUseCase {
  Future<Either<Failure, Unit>> call(NoParams params);
}
```

### 4. ViewModels não devem conhecer detalhes de implementação

```dart
// ❌ Evite
class MyViewModel {
  final AuthRepository repository;
  
  Future<void> login() {
    // Chamando repository diretamente
    await repository.signIn(email, password);
  }
}

// ✅ Prefira
class MyViewModel {
  final SignInUseCase signInUseCase;
  
  Future<void> login() {
    // Chamando use case
    await signInUseCase(SignInParams(email: email, password: password));
  }
}
```

### 5. Sempre escreva testes

```dart
// Para cada Use Case, escreva no mínimo:
// - 1 teste de sucesso
// - 1 teste de erro
// - Testes de validação (se houver)

// Para cada Repository, escreva no mínimo:
// - 1 teste de sucesso
// - 1 teste de erro de servidor
// - 1 teste de erro de cache (se aplicável)

// Para cada ViewModel, escreva no mínimo:
// - Testes de mudança de estado
// - Testes de propriedades computadas
// - Testes de interação com use cases
```

## 🎯 Checklist para Nova Feature

- [ ] Criar estrutura de pastas (domain, data, presentation)
- [ ] Criar Entity no domain
- [ ] Criar Repository interface no domain
- [ ] Criar Use Cases no domain
- [ ] Criar Models no data
- [ ] Criar Data Sources (remote e/ou local) no data
- [ ] Criar Repository implementation no data
- [ ] Criar ViewModel no presentation
- [ ] Criar Page/Widget no presentation
- [ ] Configurar injeção de dependências
- [ ] Escrever testes unitários
- [ ] Executar `flutter pub run build_runner build`
- [ ] Testar manualmente
- [ ] Documentar (README.md na pasta da feature)

## 📚 Recursos Adicionais

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Dartz Package](https://pub.dev/packages/dartz)
- [MobX Documentation](https://mobx.netlify.app/)
- [GetIt Documentation](https://pub.dev/packages/get_it)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)

##  Como Testar as Features

### 1. Testes Automatizados (Unit & Widget Tests)
Para rodar todos os testes do projeto e garantir que a refatora��o ou nova feature n�o quebrou funcionalidades existentes:

`ash
flutter test
`

Para rodar testes de uma feature espec�fica (ex: medical_shifts):

`ash
flutter test test/features/medical_shifts/
`

### 2. Testes Manuais - Fluxo de Medical Shifts
Recomendamos validar manualmente os seguintes cen�rios ap�s rodar o projeto ('flutter run'):

1. **Listagem e Filtros**
   - Acesse a tela de Plant�es (Home ou Menu).
   - Verifique se a lista inicial carrega corretamente.
   - Teste mudar o m�s/ano no calend�rio.
   - Aplique filtros por 'Pago', 'N�o Pago' e nome do Hospital.
   - Use o bot�o 'Limpar Filtros' e verifique o reset.

2. **Cadastro (CRUD)**
   - Clique em '+' ou 'Novo Plant�o'.
   - Tente salvar vazio -> Deve mostrar alerta.
   - Preencha um plant�o simples (Hospital, Valor, Data, Hora).
   - Salve -> Deve voltar � lista e exibir Toast de Sucesso.
   - Verifique se o novo item aparece na lista.

3. **Recorr�ncia**
   - No cadastro, ative 'Recorrente'.
   - Teste frequ�ncia 'Semanal' -> Deve exibir dias da semana.
   - Teste frequ�ncia 'Mensal (Dia Fixo)' -> Deve exibir seletor de dia (1-31).
   - Defina uma data final.
   - Salve e verifique se m�ltiplos plant�es foram criados no calend�rio.

4. **Edi��o e Exclus�o**
   - Abra um plant�o existente.
   - Edite o valor ou status de pagamento.
   - Salve -> Verifique atualiza��o na lista.
   - Deslize o item na lista para a esquerda -> Clique 'Deletar'.
   - Se for recorrente, deve perguntar: 'Excluir apenas este ou a s�rie toda?'.
   - Confirme e verifique a remo��o (Toast de Sucesso deve aparecer).

5. **Gera��o de PDF**
   - Na tela de listagem, clique no �cone de PDF.
   - Aplique filtros desejados e gere o relat�rio.
   - Verifique se o arquivo abre corretamente no visualizador.

