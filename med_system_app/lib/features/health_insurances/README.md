# 🏥 Feature de Convênios (Health Insurances) - Clean Architecture + MVVM

## ✅ Status da Implementação

- ✅ **Clean Architecture** implementada
- ✅ **MVVM** com MobX
- ✅ **Injeção de Dependência** com GetIt
- ✅ **Either Pattern** para tratamento de erros
- ✅ **SOLID Principles** aplicados

## 🏗️ Estrutura de Arquivos

```
lib/features/health_insurances/
├── data/
│   ├── datasources/
│   │   └── health_insurance_remote_datasource.dart
│   ├── models/
│   │   ├── health_insurance_model.dart
│   │   └── health_insurance_request_model.dart
│   └── repositories/
│       └── health_insurance_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── health_insurance_entity.dart
│   ├── repositories/
│   │   └── health_insurance_repository.dart
│   └── usecases/
│       ├── get_all_health_insurances_usecase.dart
│       ├── create_health_insurance_usecase.dart
│       └── update_health_insurance_usecase.dart
├── presentation/
│   ├── viewmodels/
│   │   ├── health_insurance_list_viewmodel.dart
│   │   ├── create_health_insurance_viewmodel.dart
│   │   └── update_health_insurance_viewmodel.dart
│   └── pages/
│       ├── health_insurances_page.dart
│       ├── add_health_insurances_page.dart
│       └── edit_health_insurance_page.dart
└── health_insurance_injection.dart
```

## 🎯 Funcionalidades

### CRUD Completo

1. **Listagem**
   - Paginação automática
   - Tratamento de estados (loading, error, empty, success)
   - Refresh indicator

2. **Criação**
   - Validação de campos (nome obrigatório)
   - Feedback visual de sucesso/erro

3. **Edição**
   - Carregamento de dados existentes
   - Validação de campos
   - Feedback visual

## 🚀 Como Usar

### ViewModels

```dart
// Listagem
final listViewModel = GetIt.I.get<HealthInsuranceListViewModel>();
await listViewModel.loadHealthInsurances();

// Criação
final createViewModel = GetIt.I.get<CreateHealthInsuranceViewModel>();
createViewModel.setName('Unimed');
await createViewModel.createHealthInsurance();

// Edição
final updateViewModel = GetIt.I.get<UpdateHealthInsuranceViewModel>();
updateViewModel.setHealthInsurance(entity);
updateViewModel.setName('Bradesco Saúde');
await updateViewModel.updateHealthInsurance();
```

## 🔄 Compatibilidade

Para garantir que outras features continuem funcionando, mantivemos temporariamente os arquivos antigos na pasta `store/` e `repository/` (raiz da feature), mas eles não estão mais sendo injetados no `service_locator.dart`.
