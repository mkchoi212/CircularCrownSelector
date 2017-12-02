<p align="center">
    <img src="./Demo.gif">
  <h3 align="center">Circular Crown Selector</h3>
  <h3 align="center">for watchOS</h3>
</p>
<br>
CircularCrownSelector is a selection menu that is controlled via Digital Crown.
The user interface is a replica of Apple's old Contact app designed for previous versions of watchOS.

## 👷 Installation
#### Step 1. Install [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod "CircularCrownSelector"
```

#### Step 2. Drag Interface from Storyboard
Go to `Source/Base.lproj/` and open `Interface.storyboard`.
`⌘-C` and `⌘-V` the only screen you see in the storyboard to your own `Interface.storyboard`. 

And voilà 🎉

## ✋ Contributing
This is an open source project so feel free to contribute by
- Opening an [issue](https://github.com/mkchoi212/CircularCrownSelector/issues/new)
- Sending me feedback via [email](mailto://mkchoi212@icloud.com)
- Or [tweet](https://twitter.com/Bananamlkshake2) at me!

## ⚠️ Notes
This library is made to be used **only with watchOS**. Xcode dictates that a project must have an iOS project for a watchOS project to exist. So, please **ignore the folder `Example-iOS`** as it is an empty project.

This library supports both 42mm and 38mm Apple Watches.

## 👮 License
See [License](./LICENSE)
