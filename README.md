# react-native-environmental

Less intrussive tool to manage many environment variables accross any part in a React Native Project.

## Installation

```sh
npm install react-native-environmental
```

## Usage

add .env's (.env.<whatever>)
android
	add apply
		apply from: "../../node_modules/react-native-environmental/android/preCompile.gradle"; initialize()
	add flavor and name it <whatever>
	reference to .env variables from gradle
		resValue "string", "<android resource name>", project.env.get("<env var>")
	reference to .env variables from code
		BuildConfig.<env var>

ios
	create Config.xcconfig
	create new scheme

		point, on every step, "Build Configuration" to "Config"
		preaction build
			set 'Provide build setting from' with the current target
			. "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopy.sh" "<whatever>"
		postaction build
			set 'Provide build setting from' with the current target
			. "${SRCROOT}/../node_modules/react-native-environmental/ios/envCopyFinish.sh"

	reference to .env variables from configuration
			${<env var>}
	reference to .env variables from code
		[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"ENV_VAR_<env var>"] UTF8String]

react-native run-android --variant=<whatever>Debug --appIdSuffix '<whatever>'

react-native run-ios --scheme "<whatever>"

## License

MIT
