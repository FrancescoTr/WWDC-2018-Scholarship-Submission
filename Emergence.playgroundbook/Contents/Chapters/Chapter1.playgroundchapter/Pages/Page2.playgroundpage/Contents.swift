/*:
 **Goal:** Run the simulation and observe the [emergence](glossary://Emergence) of segregation.
 
 This playground will show you a standard implementation of Schelling’s segregation model.
 
 The rules of the simulation are the following:
 
 * Randomly place the agents on the grid, equally divided between colors;
 * For each agent, check if the percentage of neighbors of her type is less than what she wants;
 * Move the unhappy agents to a random empty spot;
 * Repeat until every agent is happy or a fixed time limit has been reached.
 
 You can see that it doesn't take long for the agents to aggregate into clusters of the same color and to completely negate the initial random distribution, despite the fact that each agent only needs thirty percent of the neighbors to be of her same type to be happy.
 
 Would the outcome of the simulation change if we increased the number of agents or decreased the happiness threshold? You will have a chance to find out in the [next](@next) page.
  */
 //#-hidden-code
 //#-code-completion(everything, hide)
 //#-end-hidden-code

