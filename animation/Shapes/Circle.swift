import UIKit

class CircleView: UIView {
    var circleLayer: CAShapeLayer!

    init(frame: CGRect, color: UIColor = UIColor.red, lineWidth: Double = 5, radius: Double = 10) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width - CGFloat(radius), y: frame.size.height - CGFloat(radius)), radius: CGFloat(radius), startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineWidth = CGFloat(lineWidth)
        circleLayer.strokeEnd = 0.0

        layer.addSublayer(circleLayer)
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

        circleLayer.strokeEnd = 1.0
        print(circleLayer)
        circleLayer.add(animation, forKey: "draw")
    }
}
