
# Flutter Project Template

An example template for my flutter projects

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

the navigation service can also work with other navigation methods provided the abstraction is properly implemented 

## CryptoSystem
The abstract class handles encryption and decryption 

simply provide the encryption key using `buildVariables.encKey` and `buildVariables.encVector` and call the extension method built on `String`

```
"some text".encrypt()
"some text".decrypt()
```
## StorageClient
The StorageClient class is an interface meant to work directly with sharedPreferences and it has 3 methods

- read<T>
- write<T>
- delete
- deleteAll

the implemented class is `PrefsStorageImpl`

```dart
final prefs = PrefsStorageImpl();
final someValue = await prefs.read<String>('some-key');
await prefs.write<int>('some-key', 12);
```

## TO BE CONTINUED