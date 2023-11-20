```markdown
# CEP Flutter

![Flutter](https://img.shields.io/badge/Flutter-1.0.0%2B1-blue)
![Dart](https://img.shields.io/badge/Dart-%3E%3D3.1.5%20%3C4.0.0-blue)

CEP Flutter é um projeto Flutter para consultar CEPs.

## Descrição

Este projeto é uma aplicação Flutter que permite aos usuários consultar informações de CEP de forma rápida e fácil.

## Configuração

Certifique-se de definir suas dependências no arquivo `pubspec.yaml` antes de executar o projeto. Você pode fazer isso com o seguinte comando:

```bash
flutter pub get
```

- Criação do banco em : https://www.back4app.com com os seguintes campos:

- Tabela "cep"
 String "objectId" 
 String "cep"
 String "logradouro"
 String "complemento"
 String "bairro"
 String "localidade"
 String "uf"
 String ibge
 String ddd

 - Após a criação do banco você deve fornecer um arquivo `.env` na pasta `assets/` para configurar as chaves de API necessárias.
 * X-Parse-Application-Id -> .env/BACK4APPID
 * X-Parse-REST-API-Key   -> .env/BACK4APPAPIKEY

## Dependências Principais

- [dio](https://pub.dev/packages/dio) - Para fazer solicitações HTTP.
- [brasil_fields](https://pub.dev/packages/brasil_fields) - Para formatação de campos brasileiros.
- [google_fonts](https://pub.dev/packages/google_fonts) - Para usar fontes do Google.
- [top_modal_sheet](https://pub.dev/packages/top_modal_sheet) - Para mostrar modais de forma elegante.
- [crypto](https://pub.dev/packages/crypto) - Para funcionalidades de criptografia.
- [intl](https://pub.dev/packages/intl) - Para formatação de datas e números.
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) - Para configurar variáveis de ambiente.

## Executando o Projeto

Para executar o projeto, use o seguinte comando:

```bash
flutter run
```

Certifique-se de que um emulador ou dispositivo físico esteja conectado.

## Testes

Você pode executar testes no projeto usando o seguinte comando:

```bash
flutter test
```

Isso garantirá que a aplicação funcione conforme o esperado.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir problemas ou enviar solicitações de pull para melhorar este projeto.

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

```
