//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// 1
//class ComponentNode {
//    var type: String! = nil
//    var frame: CGRect! = nil
//    var prop: Dictionary<String, Any>? = nil
//    var children: [ComponentNode] = []
//
//    init(type: String, frame: CGRect, prop: Dictionary<String, Any>, children: [ComponentNode]) {
//        self.type = type
//        self.frame = frame
//        self.prop = prop
//        self.children = children
//    }
//
//}
//
//class Component {
//    public var hostView: UIView!
//    public var element: ComponentNode!
//
//    init() {
//        self.element = self.render()
//    }
//
//    func renderComponent() {
//        let new = self.render()
//        self.element = new
//
//        let uiView = createView(node: self.element)
//
//        for subview in (hostView?.subviews)! {
//            subview.removeFromSuperview()
//        }
//
//        self.hostView.addSubview(uiView)
//    }
//
//    func render() -> ComponentNode {
//        return ComponentNode(type: "view", frame: CGRect.zero, prop: [:], children: [])
//    }
//
//    func createView(node: ComponentNode) -> UIView {
//
//        switch node.type {
//        case "view":
//            let view = UIView(frame: node.frame)
//            view.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
//            for child in node.children {
//                view.addSubview(createView(node: child))
//            }
//            return view
//
//        case "label":
//            let view = UILabel(frame: node.frame)
//            view.text = node.prop?["text"] as? String
//            return view
//
//        case .none:
//            return UIView()
//        case .some(_):
//            return UIView()
//        }
//
//    }
//}
//
//let timerFrame = CGRect(x: 100, y: 100, width: 200, height: 65)
//let textFrame = CGRect(x: 60, y: 10, width: 100, height: 20)
//let textFrame2 = CGRect(x: 60, y: 30, width: 100, height: 20)
//
//class TimerComponent: Component {
//
//    var time = NSDate()
//
//    override func render() -> ComponentNode {
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//
//        return ComponentNode(type: "view", frame: timerFrame, prop: [:], children: [
//            ComponentNode(type: "label", frame: textFrame, prop: ["text": "当前时间："], children: []),
//            ComponentNode(type: "label", frame: textFrame2, prop: ["text": "\(formatter.string(from: time as Date))"], children: [])
//            ])
//    }
//}
//
//class MyViewController : UIViewController {
//
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        self.view = view
//
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
//
//    }
//
//    lazy var component: TimerComponent = {
//        let component = TimerComponent()
//        component.hostView = view
//        return component
//    }()
//
//    @objc func tick() {
//        self.component.time = NSDate()
//        self.component.renderComponent()
//    }
//
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()




// 2、diff
//class ComponentNode {
//    var type: String! = nil
//    var frame: CGRect! = nil
//    var prop: NSDictionary? = nil
//    var children: [ComponentNode] = []
//    var view: UIView?
//
//    init(type: String, frame: CGRect, prop: NSDictionary, children: [ComponentNode]) {
//        self.type = type
//        self.frame = frame
//        self.prop = prop
//        self.children = children
//    }
//}
//
//
//class Component {
//    public var parentView: UIView!
//    private var currentElement: ComponentNode?
//
//    init(parentView: UIView) {
//        self.parentView = parentView
//    }
//
//    func renderComponent() {
//        let old = self.currentElement
//        let new = self.render()
//        let element = reconcile(old: old, new: new, parentView: self.parentView)
//        self.currentElement = element
//    }
//
//    func render() -> ComponentNode {
//        return ComponentNode(type: "view", frame: CGRect.zero, prop: [:], children: [])
//    }
//
//    func reconcile(old: ComponentNode?, new: ComponentNode?, parentView: UIView) -> ComponentNode? {
//        // 首次渲染，old为空，初始化 UI
//        if old == nil {
//            instantiate(node: new!, parentView: parentView)
//            return new!
//        }
//
//        let oldNode = old!
//        let newNode = new!
//
//        //新旧节点对比，如果有更新则重新渲染新节点及其子节点
//        if oldNode.type != newNode.type || oldNode.frame != newNode.frame || oldNode.prop != newNode.prop {
//            if oldNode.view != nil {
//                oldNode.view?.removeFromSuperview()
//                oldNode.view = nil
//            }
//            instantiate(node: newNode, parentView: parentView)
//            return newNode
//        }
//
//        //子节点对比
//        newNode.children = reconcileChildren(old: oldNode, new: newNode)
//        newNode.view = oldNode.view
//        return newNode
//    }
//
//    func instantiate(node: ComponentNode, parentView: UIView) {
//        let newView = createView(node: node)
//        for index in 0..<node.children.count {
//            instantiate(node: node.children[index], parentView: newView)
//        }
//        parentView.addSubview(newView)
//        node.view = newView
//    }
//
//    func reconcileChildren(old: ComponentNode, new: ComponentNode) -> [ComponentNode] {
//        var newChildInstances: [ComponentNode] = []
//        for index in 0..<new.children.count {
//            let oldChild = old.children[index]
//            let newChild = new.children[index]
//            let newChildInstance = reconcile(old: oldChild, new: newChild, parentView: old.view!)
//            newChildInstances.append(newChildInstance!)
//        }
//        return newChildInstances
//    }
//
//    func createView(node: ComponentNode) -> UIView {
//
//        switch node.type {
//        case "view":
//            let view = UIView(frame: node.frame)
//            view.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
//            return view
//
//        case "label":
//            let view = UILabel(frame: node.frame)
//            view.text = node.prop?["text"] as? String
//            return view
//
//        case .none:
//            return UIView()
//        case .some(_):
//            return UIView()
//        }
//
//    }
//}
//
//
//let timerFrame = CGRect(x: 100, y: 100, width: 200, height: 65)
//let textFrame = CGRect(x: 60, y: 10, width: 100, height: 20)
//let textFrame2 = CGRect(x: 60, y: 30, width: 100, height: 20)
//
//class TimerComponent: Component {
//
//    var time = NSDate()
//
//    override func render() -> ComponentNode {
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//
//        return ComponentNode(type: "view", frame: timerFrame, prop: [:], children: [
//            ComponentNode(type: "label", frame: textFrame, prop: ["text": "当前时间："], children: []),
//            ComponentNode(type: "label", frame: textFrame2, prop: ["text": "\(formatter.string(from: time as Date))"], children: [])
//            ])
//    }
//}
//
//class MyViewController : UIViewController {
//
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        self.view = view
//
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
//
//    }
//
//    lazy var component: TimerComponent = {
//        let component = TimerComponent(parentView: view)
//        return component
//    }()
//
//    @objc func tick() {
//        self.component.time = NSDate()
//        self.component.renderComponent()
//    }
//
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()




//3、完整 Demo
class ComponentNode {
    var type: String! = nil
    var frame: CGRect! = nil
    var prop: NSDictionary? = nil
    var children: [ComponentNode] = []
    var view: UIView?

    init(type: String, frame: CGRect, prop: NSDictionary, children: [ComponentNode]) {
        self.type = type
        self.frame = frame
        self.prop = prop
        self.children = children
    }
}


class Component {
    public var parentView: UIView!
    private var currentElement: ComponentNode?

    init(parentView: UIView) {
        self.parentView = parentView
    }

    func renderComponent() {
        let old = self.currentElement
        let new = self.render()
        let element = reconcile(old: old, new: new, parentView: self.parentView)
        self.currentElement = element
    }

    func render() -> ComponentNode {
        return ComponentNode(type: "view", frame: CGRect.zero, prop: [:], children: [])
    }

    func reconcile(old: ComponentNode?, new: ComponentNode?, parentView: UIView) -> ComponentNode? {
        // 首次渲染，old为空，初始化 UI
        if old == nil {
            instantiate(node: new!, parentView: parentView)
            return new!
        } else if (new == nil) {
            old?.view?.removeFromSuperview()
            return nil
        }

        let oldNode = old!
        let newNode = new!

        //新旧节点对比，如果有更新则重新渲染新节点及其子节点
        if oldNode.type != newNode.type || oldNode.frame != newNode.frame || oldNode.prop != newNode.prop {
            if oldNode.view != nil {
                oldNode.view?.removeFromSuperview()
                oldNode.view = nil
            }
            instantiate(node: newNode, parentView: parentView)
            return newNode
        }

        //子节点对比
        newNode.children = reconcileChildren(old: oldNode, new: newNode)
        newNode.view = oldNode.view
        return newNode
    }

    func instantiate(node: ComponentNode, parentView: UIView) {
        let newView = createView(node: node)
        for index in 0..<node.children.count {
            instantiate(node: node.children[index], parentView: newView)
        }
        parentView.addSubview(newView)
        node.view = newView
    }

    func reconcileChildren(old: ComponentNode, new: ComponentNode) -> [ComponentNode] {
        var newChildInstances: [ComponentNode] = []
        let count = max(old.children.count, new.children.count)
        for index in 0..<count {
            let oldChild = old.children.count > index ? old.children[index] : nil
            let newChild = new.children.count > index ? new.children[index] : nil
            let newChildInstance = reconcile(old: oldChild, new: newChild, parentView: old.view!)
            if newChildInstance != nil {
                newChildInstances.append(newChildInstance!)
            }
        }
        return newChildInstances
    }

    func createView(node: ComponentNode) -> UIView {

        switch node.type {
        case "view":
            let view = UIView(frame: node.frame)
            view.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
            return view

        case "label":
            let view = UILabel(frame: node.frame)
            view.text = node.prop?["text"] as? String
            return view

        case .none:
            return UIView()
        case .some(_):
            return UIView()
        }

    }
}


let timerFrame = CGRect(x: 100, y: 100, width: 200, height: 85)
let textFrame = CGRect(x: 60, y: 10, width: 100, height: 20)
let textFrame2 = CGRect(x: 60, y: 30, width: 100, height: 20)
let textFrame3 = CGRect(x: 60, y: 50, width: 100, height: 20)

class TimerComponent: Component {

    var time = NSDate()

    var flag = false

    override func render() -> ComponentNode {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"

        self.flag = !self.flag

        if self.flag {
            return ComponentNode(type: "view", frame: timerFrame, prop: [:], children: [
                ComponentNode(type: "label", frame: textFrame, prop: ["text": "当前时间："], children: []),
                ComponentNode(type: "label", frame: textFrame2, prop: ["text": "\(formatter.string(from: time as Date))"], children: []),
                ComponentNode(type: "label", frame: textFrame3, prop: ["text": "\(formatter.string(from: time as Date))"], children: [])
                ])
        }
        return ComponentNode(type: "view", frame: timerFrame, prop: [:], children: [
            ComponentNode(type: "label", frame: textFrame, prop: ["text": "当前时间："], children: []),
            ComponentNode(type: "label", frame: textFrame2, prop: ["text": "\(formatter.string(from: time as Date))"], children: [])
            ])
    }
}

class MyViewController : UIViewController {

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        self.view = view

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

    }

    lazy var component: TimerComponent = {
        let component = TimerComponent(parentView: view)
        return component
    }()

    @objc func tick() {
        self.component.time = NSDate()
        self.component.renderComponent()
    }

}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
