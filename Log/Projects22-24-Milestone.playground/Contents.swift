import UIKit

extension UIView {
    
    func bounceOut(duration: Double) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

extension Int {
    
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        
        for _ in 0..<self {
            closure()
        }
    }
}

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}

let testView = UIView()
testView.bounceOut(duration: 5)

10.times {
    print("Testing")
}

var array = [1, 2, 3, 4]
array.remove(at: 3)

print(array)
