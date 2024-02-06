
# Flutter Project Template

An example template for afex flutter projects

## Environment Variables


To run this project, you will need to add the following environment variables to your .env file

`BASE_URL`
`ENC_KEY`
`ENC_VECTOR`


## Registered Services

- NavigationService
- CryptoSystem
- StorageClient
- EncryptedStorageClient
- DatabaseStorage
- ApiClient
## Navigation Service

To use the navigation service, an extension has been created on `BuildContext` with the methods below

```dart
context.navigator.go('path-to-screen')
context.navigator.push('path-to-screen')
context.navigator.pushReplacement('path-to-screen')
context.navigator.goNamed('path-to-screen')
context.navigator.pushReplacementNamed('path-to-screen')
context.navigator.pop()
```

the navigation service currently works with gorouter and allows passing objects through the `extra` property, it also has `queryParameters` and `pathParameters`

all methods except `go` and `goNamed` are futures that allows value to be returned to the previous screen