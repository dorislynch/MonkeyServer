
# react-native-monkey-server

## Getting started

`$ npm install react-native-monkey-server --save`

### Mostly automatic installation

`$ react-native link react-native-monkey-server`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-monkey-server` and add `RNMonkeyServer.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNMonkeyServer.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNMonkeyServerPackage;` to the imports at the top of the file
  - Add `new RNMonkeyServerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-monkey-server'
  	project(':react-native-monkey-server').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-monkey-server/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-monkey-server')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNMonkeyServer.sln` in `node_modules/react-native-monkey-server/windows/RNMonkeyServer.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Monkey.Server.RNMonkeyServer;` to the usings at the top of the file
  - Add `new RNMonkeyServerPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNMonkeyServer from 'react-native-monkey-server';

// TODO: What to do with the module?
RNMonkeyServer;
```
  