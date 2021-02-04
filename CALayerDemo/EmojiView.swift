//
//  EmojiView.swift
//  CALayerDemo
//
//  Created by Mac on 2021/2/3.
//

import UIKit

class EmojiView: UIView {
    let emojiLayers : [CALayer]
    override init(frame: CGRect) {
        let emojiList = "😄🤣😄😀🙂😜🤠😙🤑😑😡😠😟😞🤡😳😘😉😀😇😍🤗🤔☹️😕🙄😎😌"
        let screenScale = UIScreen.main.scale
        let cornerInset = 45
        let layerSize = 70
        
        var index = 0
        var emojiLayers:[CALayer] = []
        for e in emojiList {
            let layer = CATextLayer()
            layer.string = String(e)
            layer.fontSize = 50
            layer.contentsScale = screenScale
            layer.bounds = CGRect(x: 0, y: 0, width: layerSize, height: layerSize)
            layer.alignmentMode = .center
            
            let column = index % 4
            let row = (index - column) / 4
            layer.position = CGPoint(x: cornerInset + layerSize * column, y: cornerInset + layerSize * row)
           
            emojiLayers.append(layer)
            index = index + 1
        }
        
        self.emojiLayers = emojiLayers
        super.init(frame: frame)
        self.layer.cornerRadius = 40
        for layer in self.emojiLayers {
            self.layer.addSublayer(layer)
        }
//        self.layer.anchorPoint = CGPoint(x: 0, y: 0)
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
