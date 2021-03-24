import UIKit

class RectangleView: UIView {
    var rectangleLayer: CAShapeLayer!

    init(frame: CGRect, color: UIColor = UIColor.red, lineWidth: Double = 5, radius: Double = 0) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        let rectanglePath = UIBezierPath(roundedRect: frame, cornerRadius: CGFloat(radius))
        rectangleLayer = CAShapeLayer()
        rectangleLayer.path = rectanglePath.cgPath
        rectangleLayer.fillColor = UIColor.clear.cgColor
        rectangleLayer.strokeColor = color.cgColor
        rectangleLayer.lineWidth = CGFloat(lineWidth)
        rectangleLayer.strokeEnd = 0.0
        
        layer.addSublayer(rectangleLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func draw(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        rectangleLayer.strokeEnd = 1.0
        rectangleLayer.add(animation, forKey: "draw")
    }
}
