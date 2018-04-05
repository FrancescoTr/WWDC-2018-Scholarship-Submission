import UIKit
import SpriteKit


public class SimulationViewController:UIViewController {
    var sceneView = SKView(frame: CGRect(x:0 , y:0, width: 400, height: 800))
    public var simulation:Simulation?
    public var parameters:Parameters?
    var consoleView = UIView(frame: CGRect(x: 0, y: 0, width: 768, height: 40))
    var startButton:UIButton!
    var resetButton:UIButton!
    var stepButton:UIButton!
    let buttonsBackgroundColor = UIColor.red
    let buttonsTitleColor = UIColor.black
    let buttonsHeight = CGFloat(30)
    let buttonsWidth = CGFloat(70)
    let buttonsCornerRadius = CGFloat(10)
    let barOffset = CGFloat(60)
    var consoleConstraint:NSLayoutConstraint!
    //MARK: - Initializers & Setup
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        var portrait = false
        if view.frame.size.width > view.frame.size.height {
            sceneView = SKView(frame: CGRect(x:0 , y:0, width: view.frame.size.width / 2, height: view.frame.height))
        } else {
            sceneView = SKView(frame: CGRect(x:0 , y:0, width: view.frame.size.width, height: view.frame.height / 2))
            portrait = true
        }
        simulation = Simulation(parameters:parameters ?? Parameters.standardParameters, sceneView: sceneView)
        simulation?.setup()
        simulation?.delegate = self
        let scene = SimulationScene(size: sceneView.frame.size, simulation: simulation!)
        //scene.scaleMode = .resizeFill
        self.view.addSubview(sceneView)
        setupButtonsConsole()
        if portrait {
            consoleConstraint.constant = barOffset
        }
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.view.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor).isActive = true
        sceneView.presentScene(scene)
    }
    
    override public func viewDidLayoutSubviews() {
        //super.viewDidLayoutSubviews()
        sceneView.frame.size = view.frame.size
        consoleView.frame.size.width = view.frame.width
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if (simulation?.isPaused) == false {
            pause()
        }
        sceneView.frame.size = size
        simulation = Simulation(parameters:parameters ?? Parameters.standardParameters, sceneView: sceneView)
        simulation?.setup()
        simulation?.delegate = self
        let scene = SimulationScene(size: sceneView.frame.size, simulation: simulation!)
        if size.width > size.height {
            consoleConstraint.constant = barOffset
        } else {
            consoleConstraint.constant = 0
        }
        sceneView.presentScene(scene)
        
    }
    
    func setupButtonsConsole() {
        consoleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        self.view.addSubview(consoleView)
        setupConsoleConstraints()
        //startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        startButton = UIButton(type: .system)
        startButton.layer.cornerRadius = buttonsCornerRadius
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = buttonsBackgroundColor
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(buttonsTitleColor, for: .normal)
        startButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        resetButton = UIButton(type: .system)
        //resetButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        resetButton.layer.cornerRadius = buttonsCornerRadius
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.backgroundColor = buttonsBackgroundColor
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(buttonsTitleColor, for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        //stepButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        stepButton = UIButton(type: .system)
        stepButton.layer.cornerRadius = buttonsCornerRadius
        stepButton.translatesAutoresizingMaskIntoConstraints = false
        stepButton.backgroundColor = buttonsBackgroundColor
        stepButton.setTitle("STEP", for: .normal)
        stepButton.setTitleColor(buttonsTitleColor, for: .normal)
        stepButton.addTarget(self, action: #selector(step), for: .touchUpInside)
        consoleView.addSubview(startButton)
        consoleView.addSubview(resetButton)
        consoleView.addSubview(stepButton)
        setButtonConstraints()
    }
    
    func setupConsoleConstraints() {
        consoleView.translatesAutoresizingMaskIntoConstraints = false
        consoleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        consoleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        consoleConstraint = consoleView.topAnchor.constraint(equalTo: view.topAnchor)
        consoleConstraint.isActive = true
        consoleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        consoleView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    func setButtonConstraints() {
        startButton.leftAnchor.constraint(equalTo: (startButton.superview?.leftAnchor)!, constant: 8).isActive = true
        //startButton.topAnchor.constraint(equalTo: (startButton.superview?.topAnchor)!, constant: 10).isActive = true
        startButton.centerYAnchor.constraint(equalTo: (startButton.superview?.centerYAnchor)!).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: buttonsWidth).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        resetButton.rightAnchor.constraint(equalTo: (resetButton.superview?.rightAnchor)!, constant: -8).isActive = true
        //resetButton.topAnchor.constraint(equalTo: (resetButton.superview?.topAnchor)!, constant: 10).isActive = true
        resetButton.centerYAnchor.constraint(equalTo: (resetButton.superview?.centerYAnchor)!).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: buttonsWidth).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        stepButton.leftAnchor.constraint(equalTo: startButton.rightAnchor, constant: 8).isActive = true
        //stepButton.topAnchor.constraint(equalTo: (stepButton.superview?.topAnchor)!, constant: 10).isActive = true
        stepButton.centerYAnchor.constraint(equalTo: (stepButton.superview?.centerYAnchor)!).isActive = true
        stepButton.widthAnchor.constraint(equalToConstant: buttonsWidth).isActive = true
        stepButton.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        stepButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    //MARK: - Button actions
    
    @objc public func pause() {
        if (simulation?.isPaused) == true {
            simulation?.start()
            startButton.setTitle("PAUSE", for: .normal)
        } else {
            simulation?.pause()
           startButton.setTitle("START", for: .normal)
        }
    }
    
    @objc public func reset() {
        if (simulation?.isPaused) == false {
            pause()
        }
        simulation?.reset()
    }
    
    @objc public func step() {
        if (simulation?.isPaused) == false {
            pause()
        }
        sceneView.scene?.update(0)
    }
    
    // MARK: - Set parameters for experiments
    
    public func setDensity(density:Double) {
        guard self.parameters == nil else {
            parameters?.density = density
            return
        }
        parameters = Parameters.standardParameters
        parameters?.density = density
    }
    
    public func setNumberOfColors(number:Int) {
        guard self.parameters == nil else {
            parameters?.numberOfColors = number
            return
        }
        parameters = Parameters.standardParameters
        parameters?.numberOfColors = number
    }
    
    public func setHappinessThreshold(threshold:Double) {
        guard self.parameters == nil else {
            parameters?.happinesThreshold = threshold
            return
        }
        parameters = Parameters.standardParameters
        parameters?.happinesThreshold = threshold
    }
    
    public func setSpeed(speed:Int) {
        guard self.parameters == nil else {
            parameters?.speed = speed
            return
        }
        parameters = Parameters.standardParameters
        parameters?.speed = speed
    }
}


extension SimulationViewController:SimulationDelegate {
    
    func simulationDidReset() {
        startButton.isEnabled = true
        startButton.alpha = 1
        stepButton.isEnabled = true
        stepButton.alpha = 1
    }
    
    func simulationDidEnd() {
        pause()
        startButton.isEnabled = false
        startButton.alpha = 0.5
        stepButton.isEnabled = false
        stepButton.alpha = 0.5
    }
}

