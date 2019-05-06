# SMControl
[![Swift/5.0](https://img.shields.io/badge/swift-5.0-brightgreen.svg?style=flat-square)](https://developer.apple.com/swift/)

Control library for iOS written on Swift

## Features

- Set control image
- Configure image size by percent
- Interface Builder preview
- Set control actions with blocks

## Example

```swift
control.image = UIImage(named: "volumeUp")
control.imageScale = 0.7
control.addActionBlock(event: .touchUpInside) { control in
	print("Volume up button pressed")
}
```

## Installation

Copy the `SMControl/SMControl.swift` file into your project.  



## Contact

Alexey Siginur siginur@gmail.com

## License

SMControl source code is available under the MIT License.
