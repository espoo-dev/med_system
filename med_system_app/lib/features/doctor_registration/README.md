# 👨‍⚕️ Feature de Cadastro de Médico - Clean Architecture + MVVM

## ✅ Status da Implementação

- ✅ **Clean Architecture** implementada
- ✅ **MVVM** com MobX
- ✅ **Injeção de Dependência** com GetIt
- ✅ **Either Pattern** para tratamento de erros
- ✅ **SOLID Principles** aplicados

## 🏗️ Estrutura de Arquivos

```
lib/features/doctor_registration/
├── data/
│   ├── datasources/
│   │   └── signup_remote_datasource.dart
│   ├── models/
│   │   ├── signup_model.dart
│   │   └── signup_request_model.dart
│   └── repositories/
│       └── signup_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── signup_entity.dart
│   ├── repositories/
│   │   └── signup_repository.dart
│   └── usecases/
│       └── signup_usecase.dart
├── presentation/
│   ├── viewmodels/
│   │   └── signup_viewmodel.dart
│   └── pages/
│       └── signup_page.dart
└── doctor_registration_injection.dart
```

## 🎯 Funcionalidades

### Validações Implementadas

1. **Email**
   - Não pode ser vazio
   - Deve ser um email válido (regex)
   - Mínimo de 4 caracteres

2. **Senha**
   - Não pode ser vazia
   - Mínimo de 6 caracteres
   - Deve coincidir com a confirmação

3. **Confirmação de Senha**
   - Validação em tempo real
   - Feedback visual quando não coincide

### Tratamento de Erros

- ✅ Usuário já cadastrado (422)
- ✅ Dados inválidos (400)
- ✅ Erro de conexão
- ✅ Erros genéricos do servidor

## 🚀 Como Usar

### Navegação para a Página

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SignUpPage(),
  ),
);
```

### ViewModel

```dart
final viewModel = GetIt.I.get<SignUpViewModel>();

// Setters
viewModel.setEmail('email@example.com');
viewModel.setPassword('senha123');
viewModel.setConfirmPassword('senha123');

// Ação
await viewModel.signUp();

// Estados
viewModel.isLoading  // bool
viewModel.canSubmit  // bool
viewModel.passwordsDoNotMatch  // bool
viewModel.errorMessage  // String
```

## 📝 Fluxo de Cadastro

1. Usuário preenche email, senha e confirmação
2. ViewModel valida os dados em tempo real
3. Ao submeter, UseCase executa validações adicionais
4. Repository faz chamada à API
5. Em caso de sucesso, navega para tela de login
6. Em caso de erro, exibe toast com mensagem

## 🔄 Compatibilidade

Para garantir que outras features continuem funcionando, mantivemos temporariamente:
- `lib/features/doctor_registration/repository/signup_repository.dart` (Antigo)
- `lib/features/doctor_registration/store/signup.store.dart` (Antigo)

Esses arquivos devem ser removidos apenas quando todas as features dependentes forem migradas.
