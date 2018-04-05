/*:
 # The Schelling Segregation Model
 This playground is an exploration of the famous segregation model that American economist and Nobel Prize winner Thomas Schelling introduced in the late 60's.
 
 The [model](glossary://Model) is important because it shows how individual preferences and behaviors can lead to unexpected consequences and, in this specific case, how a slight preference for similar neighbors can lead to complete segregation even if no individual [agent](glossary://Agent) desires it.
 
 **Goal:** Understand the rules governing the agents' behavior.
 
 This [simulation](glossary://Simulation) consists of several agents, randomly distributed in a grid-like world, that only differ in one attribute represented by different colors. The agents get along fine but they also desire a certain number of neighbors of their same type. If an agent is not happy with the composition of her neighborhood, she moves to a random empty cell until she finds a satisfactory location.
 
 ## Agent behavior:
 * Count neighbors of my same type;
 * Check if the percentage of neighbors of my type is less than what I want;
 * If so, move to a random empty cell otherwise stay put.
 
 * Experiment:
  Tap on an empty cell and check where the red agent near the top-left corner can find a satisfying    position.
 
 As you have probably discovered, our agent only needs three neighbors of his color to be happy.
 In the [next](@next) page, we will place several hundred agents on the grid in order to observe what kind of aggregate pattern emerges from the individuals' behavior.
 */
 //#-hidden-code
 //#-code-completion(everything, hide)
 //#-end-hidden-code
 


