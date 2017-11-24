//
//  CrownSelectorInterfaceController.swift
//  Circular Crown Selector WatchKit Extension
//
//  Created by Mike Choi on 11/24/17.
//  Copyright © 2017 Mike Choi. All rights reserved.
//

import WatchKit

class CrownSelectorInterfaceController: WKInterfaceController, WKCrownDelegate {
  @IBOutlet var c1: WKInterfaceGroup!
  @IBOutlet var c2: WKInterfaceGroup!
  @IBOutlet var c3: WKInterfaceGroup!
  @IBOutlet var c4: WKInterfaceGroup!
  @IBOutlet var c5: WKInterfaceGroup!
  @IBOutlet var c6: WKInterfaceGroup!
  @IBOutlet var c7: WKInterfaceGroup!
  @IBOutlet var c8: WKInterfaceGroup!
  @IBOutlet var c9: WKInterfaceGroup!
  @IBOutlet var c10: WKInterfaceGroup!
  @IBOutlet var c11: WKInterfaceGroup!
  @IBOutlet var c12: WKInterfaceGroup!
  @IBOutlet var currentLabel: WKInterfaceLabel!
  var circles : [WKInterfaceGroup]!

  var idx: Int!

  var deltaBuildUp: Double!
  let sensitivity = 0.8
  var initials : [String]!
  var fontColors : [UIColor] = []
  
  let activeFontColor = UIColor(red: 110.0/255.0, green: 64.0/255.0, blue: 0.0/255.0, alpha: 1.0)
  let activeColor = UIColor(red: 255.0/255.0, green: 148.0/255.0, blue: 3.0/255.0, alpha: 1.0)
  let inactiveColor = UIColor(red: 38.0/255.0, green: 38.0/255.0, blue: 40.0/255.0, alpha: 1.0)
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    if let initials = context as? [String] {
      self.initials = initials
    } else {
      self.initials = generateInitials()
    }
    initials = fillBlankSpots(of: initials, with: "●")
    
    circles = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12]

    _ = zip(circles, initials).map { (tup) -> Void in
      let (cir, str) = tup
      let fontColor = randomColor()
      fontColors.append(fontColor)
      cir.setBackgroundColor(inactiveColor)
      return cir.setBackgroundImage(stringToImage(str, color: fontColor))
    }
    c1.setBackgroundColor(activeColor)
  }
  
  override func willActivate() {
    // Make `crownSequncer` responsive
    crownSequencer.delegate = self
    crownSequencer.focus()
    deltaBuildUp = 0
    idx = 0
    setActive(0)
  }

  func fillBlankSpots(of arr: [String], with str: String) -> [String] {
    let diff = 12 - arr.count
    let filledArray = arr + Array(repeating: str, count: diff)
    return filledArray
  }
  
  // Set group at idx active by changing color attributes
  func setActive(_ idx: Int) {
    circles[idx].setBackgroundColor(activeColor)
    circles[idx].setBackgroundImage(stringToImage(initials[idx], color: activeFontColor))
    currentLabel.setText(initials[idx])
  }
  
  func setInActive(_ idx: Int) {
    circles[idx].setBackgroundColor(inactiveColor)
    circles[idx].setBackgroundImage(stringToImage(initials[idx], color: fontColors[idx]))
  }
  
  // MARK: WKCrownDelegate
  func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
    // Only act on crown rotation if `deltaBuildUp` is greater than sensitivity
    // for smoother / controllable scrolling experience
    deltaBuildUp = deltaBuildUp.sign != rotationalDelta.sign ? 0 : deltaBuildUp
    deltaBuildUp = deltaBuildUp + rotationalDelta
    
    if abs(deltaBuildUp) < sensitivity {
      return
    }

    setInActive(idx)

    idx = rotationalDelta > 0 ? idx + 1  : idx - 1;
    idx = idx % 12
    if idx < 0 {
      idx = 12 + idx
    }
    
    setActive(idx)
    deltaBuildUp = 0.0
  }

  // MARK: Helper Functions
  private func stringToImage(_ str: String, color: UIColor) -> UIImage? {
    let imageSize = CGSize(width: 23, height: 23)
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    UIColor.clear.set()
    let rect = CGRect(origin: CGPoint.zero, size: imageSize)
    UIRectFill(rect)
   
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    (str as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
                                                      NSAttributedStringKey.paragraphStyle: style,
                                                      NSAttributedStringKey.foregroundColor: color,
                                                      NSAttributedStringKey.baselineOffset: -3.0])
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
 
  private func generateInitials() -> [String] {
    let randomString = UUID().uuidString
    let str = randomString.replacingOccurrences(of: "-", with: "")

    let initials = stride(from: 0, to: 18, by: 2).map { i -> String in
        let start = str.index(str.startIndex, offsetBy: i)
        let end = str.index(str.startIndex, offsetBy: i + 2)
        return String(str[start..<end])
    }
    
    return initials
  }
  
  private func randomColor() -> UIColor {
    let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
    let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
    let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.7  //  0.7 to 1.0, away from black
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
  }
}
