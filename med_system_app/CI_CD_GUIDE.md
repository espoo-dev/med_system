# 🚀 Guia de CI/CD - Med System App

Este projeto utiliza **GitHub Actions** para automação de Integração Contínua (CI) e Entrega Contínua (CD).

## 🔄 Workflows

### 1. Flutter CI (`flutter_ci.yml`)
Executado automaticamente em todo `push` e `pull_request` para as branches principais (`main`, `master`, `develop`).

**O que ele faz:**
1.  Configura o ambiente Java e Flutter.
2.  Instala dependências (`flutter pub get`).
3.  Gera códigos (`build_runner`).
4.  Analisa o código em busca de erros e problemas de estilo (`flutter analyze`).
5.  Executa todos os testes unitários (`flutter test`).

### 2. Flutter CD (`flutter_cd.yml`)
Executado automaticamente quando uma nova **Release** é publicada no GitHub.

**O que ele faz:**
1.  Prepara o ambiente.
2.  Gera o APK de Release.
3.  Faz upload do APK gerado para os Assets da Release no GitHub.

---

## 🔐 Configuração para Produção (Assinatura Android)

Para gerar builds assinados prontos para a Play Store, você precisa configurar as Secrets no GitHub.

### 1. Gerar Keystore (se não tiver)
```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 2. Codificar Keystore em Base64
No Linux/Mac:
```bash
base64 upload-keystore.jks > keystore_base64.txt
```
No Windows (PowerShell):
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("./upload-keystore.jks")) > keystore_base64.txt
```

### 3. Adicionar Secrets no GitHub
Vá em `Settings > Secrets and variables > Actions` e adicione:

- `ANDROID_KEYSTORE_BASE64`: Conteúdo do arquivo `keystore_base64.txt`.
- `ANDROID_KEYSTORE_PASSWORD`: Senha do keystore.
- `ANDROID_KEY_ALIAS`: Alias da chave (ex: upload).
- `ANDROID_KEY_PASSWORD`: Senha da chave.

### 4. Atualizar `flutter_cd.yml`
Descomente e ajuste a seção de build para usar as secrets e assinar o app.

```yaml
      - name: Create Keystore
        run: |
          echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | base64 --decode > android/app/upload-keystore.jks

      - name: Build Signed APK
        run: flutter build apk --release
        env:
          KEY_STORE_PASSWORD: ${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
          KEY_ALIAS: ${{ secrets.ANDROID_KEY_ALIAS }}
          KEY_PASSWORD: ${{ secrets.ANDROID_KEY_PASSWORD }}
```

E no `android/key.properties`, configure para ler essas variáveis de ambiente.
