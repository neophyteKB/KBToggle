//
//  KBToggle.swift
//  SharpOne
//
//  Created by kamal on 12/22/16.
//  Copyright © 2016 Neophyte. All rights reserved.
//

import UIKit

@IBDesignable

class KBToggle: UIView {
    
    var imgThumb: UIImage?
    var toggleLook: Bool = false
    var numberOfSegments: Int = 2
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14.0)
    var titleFontSize: CGFloat = 14.0
    var thumb: UIImageView!
    var selectedState: (String?, Int)?
    
    @IBInspectable var thumbColor : UIColor?{
        didSet{
            let color = thumbColor == nil ? UIColor.red : thumbColor
            imgThumb = imageOfColor(color: color!)
        }
    }
    @IBInspectable var thumbImage : String?{
        didSet{
            if thumbImage != nil{
                let image = UIImage(named: thumbImage!)
                if image != nil{
                    imgThumb = image
                }
            }
        }
    }
    @IBInspectable var circularShape : Bool = false{
        didSet{
            toggleLook = circularShape
            layer.cornerRadius = frame.size.height / 2
            clipsToBounds = true
        }
    }
    
    @IBInspectable var segments : Int = 2{
        didSet{
            let height = self.frame.size.height
            let width = self.frame.size.width / CGFloat(segments)
            createThumbView(width, height)
            self.addSubview(thumb)
        }
    }
    
    func initWithTitles(_ titles: [String], defaultSelectedIndex: Int){
        
        let height = self.frame.size.height
        let width = self.frame.size.width / CGFloat(titles.count)
        if thumb == nil{
            createThumbView(width, height)
        }
        
        var originX: CGFloat = 0
        for title in titles{
            let btn = UIButton(frame: CGRect(x: originX, y: 0, width: width, height: height))
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = titleFont
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
            let index = titles.index(of: title)
            btn.tag = index!
            self.addSubview(btn)
            if thumb == nil{
                self.addSubview(thumb)
            }
            if defaultSelectedIndex == index{
                thumb.center = btn.center
            }
            originX += width
        }
    }
    
    func createThumbView(_ width: CGFloat, _ height: CGFloat){
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        imageView.image = imgThumb
        imageView.layer.cornerRadius = height/2
        imageView.clipsToBounds = true
        imageView.layer.borderColor = backgroundColor?.cgColor
        imageView.layer.borderWidth = 1.0
        thumb = imageView
    }

    func imageOfColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func btnPressed(_ sender: UIButton){
        UIView.animate(withDuration: 0.35, animations:{
            self.thumb.center = sender.center
        })
        selectedState = (sender.currentTitle, sender.tag)
    }

}
