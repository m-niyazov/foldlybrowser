import UIKit
import SkeletonView

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

    func hideElements(_ elements: [UIView]) {
        elements.forEach { view in
            view.isHidden = true
        }
    }

    func showElements(_ elements: [UIView]) {
        elements.forEach { view in
            view.isHidden = false
        }
    }

    func showCustomSkeleton(_ baseBgColor: UIColor = .black) {
        self.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: baseBgColor)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        self.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
    }

    func hideCustomSkeleton() {
        self.hideSkeleton(reloadDataAfter: false)
    }

    func startShimmeringEffect() {
        let light = UIColor.white.cgColor
        let alpha = UIColor(red: 206 / 255, green: 10 / 255, blue: 10 / 255, alpha: 0.7).cgColor
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(
            x: -self.bounds.size.width,
            y: 0,
            width: 3 * self.bounds.size.width,
            height: self.bounds.size.height)
        gradient.colors = [light, alpha, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.35, 0.50, 0.65]
        self.layer.mask = gradient
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 2.2
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }

    func stopShimmeringEffect() {
        self.layer.mask = nil
    }
}

// MARK: - Round Corner
extension UIView {
    func roundCorners(corners: [RoundCorner] = [.topLeft, .topRight, .bottomRight, .bottomLeft], curve: CornerCurve = .continuous, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(corners.map { $0.value() })

        if #available(iOS 13.0, tvOS 13.0, *) {
            layer.cornerCurve = curve.layerCornerCurve
        }
    }

    enum RoundCorner {
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft

        func value() -> CACornerMask {
            switch self {
            case .topRight:
                return .layerMaxXMinYCorner
            case .topLeft:
                return .layerMinXMinYCorner
            case .bottomRight:
                return .layerMaxXMaxYCorner
            case .bottomLeft:
                return .layerMinXMaxYCorner
            }
        }
    }

    enum CornerCurve {
        case circle
        case continuous

        var layerCornerCurve: CALayerCornerCurve {
            switch self {
            case .circle: return .circular
            case .continuous: return .continuous
            }
        }
    }
}


// MARK: Gradient
enum GradientDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case bottomRightToTopLeft
    case topRightToBottomLeft
    case bottomLeftToTopRight
}

extension UIView {
    func applyGradient(colors: [UIColor], direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.frame = self.bounds

        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case .bottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        case .bottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
