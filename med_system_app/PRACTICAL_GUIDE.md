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
