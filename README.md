# WWDC-2018-Scholarship-Submission

My playground is an exploration of Thomas Schelling’s segregation model. Thomas Schelling, an American economist and Nobel prize winner, was a pioneer in behavioural economics and one of the fathers of agent-based modelling. 

In the late 60’s and early 70’s, Schelling proposed his model of segregation which shows how individual preferences and behaviors can generate aggregate outcomes that are difficult to foresee. The model consists of a certain number of agents, randomly distributed in a grid-like world, that differ only in one attribute represented by their color. The agents get along but they also desire to have a certain percentage of neighbors of the same type. If an agent is unhappy with the composition of her neighborhood, she moves to a random empty spot on the grid until she finds a satisfying location. The model shows how even a very limited preference for agents of the same color (e.g. 20%) can lead to complete segregation, an outcome which no agent in the model desires.

The playground book comprises three pages: the first one is an introduction to the model and the rules of the simulation; the second one shows a run of the simulation with standard parameters; and the last one allows the user to change the parameters and observe the outcome.

The simulation can be explored by setting four parameters:

* The population density which determines the number of agents on the grid;
* The number of different types of agent;
* The percentage of neighbors of the same type that the agents want;
* The speed of the simulation.

The playground was implemented using SpriteKit to show the simulation, UIKit for the interface, and it also takes advantage of several features of Playground Books, such as page annotations, glossary and PlaygroundSupport module.


