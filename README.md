# react-native-environmental

Less intrussive tool to manage many environment variables accross native and javascript code in a React Native Projects.

## Installation

```sh
npm install react-native-environmental
```

## Usage
(🚧  Under Construction)

add .env's (.env.<whatever>)
android
	add apply
		apply from: "../../node_modules/react-native-environmental/android/preCompile.gradle"; initialize()
	add flavor and name it <whatever>
	reference to .env variables from gradle
		project.env.get("<env var>")
			EXAMPLE:
		resValue "string", "<android resource name>", project.env.get("<env var>")
			NOTE:
		if you want to use an env data inside a string resource you have to delete it from the stringd.xml.
		for example if you want to replace the app_name, before build you have to remove from app/res/stringd.xml the line <string name="app_name">ZankyouMobileApp</string>
		

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
react-native run-android --variant=<whatever>Debug --appId '<appid_of_whatever>'

react-native run-ios --scheme "<whatever>"

## License

MIT





PRODUCT_BUNDLE_IDENTIFIERx
