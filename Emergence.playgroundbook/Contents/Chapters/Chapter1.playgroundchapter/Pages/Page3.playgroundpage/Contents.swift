/*:
 **Goal:** Change the [parameters](glossary://Parameters) of the simulation and observe the results.
 
 The main parameters of the simulation are the following:
 
 * **Density**, which controls the number of agents on the grid (Nº of agents = Density * (Nº of rows * Nº of columns));
 * **Number of colors**, the number of types of agent;
 * **Happiness threshold**, the percentage of neighbors of the same type that each agent needs to be happy.
 
 By default, the parameters are set to: **Density = 0.8; Number of colors = 2; Happiness threshold = 0.3**.
 
 Try to change this settings and check if the agents segregate and how long it takes to happen.
 */
 //#-hidden-code
 //#-code-completion(everything, hide)
 import PlaygroundSupport
 import UIKit
 let simulation = SimulationViewController()
 //#-end-hidden-code
 // Try to change the agents' density on the grid
simulation.setDensity(density: /*#-editable-code*/<#T##Try 0.5##Double#>/*#-end-editable-code*/)

// Check what happens with more the two types of agents (Max: 4)
simulation.setNumberOfColors(number: /*#-editable-code*/<#T##Try 3##Int#>/*#-end-editable-code*/)

// Modify the happiness threshold for the agents
simulation.setHappinessThreshold(threshold: /*#-editable-code*/<#T##Try 0.2##Double#>/*#-end-editable-code*/)

// You can also change the speed of the simulation
simulation.setSpeed(speed: /*#-editable-code*/<#T##Try 20##Int#>/*#-end-editable-code*/)

//#-hidden-code
PlaygroundPage.current.liveView = simulation
//#-end-hidden-code

