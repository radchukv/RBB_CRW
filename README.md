# Reusable Building Block (RBB)

## 1. Name of the RBB

Correlated Random Walk (CRW) to describe agent’s (e.g. animals or humans) movement in homogeneous landscapes


## 2. Authors names and affiliations

Viktoriia Radchuk, _Department of Ecological dynamics, Leibniz Institute for Zoo and Wildlife Research_     
Thibault Fronville, _Department of Ecological dynamics, Leibniz Institute for Zoo and Wildlife Research_        
Uta Berger, _Institute of Forest Growth and Computer Sciences, TU Dresden_   

## 3. Keywords 

movement, animals, local movement, foraging  


## 4. Purpose

The goal of CRW is to represent the movement of animal individuals, in two-dimensional space. When modeled as correlated random walk, the direction of movement at any time step is correlated with the direction of movement at the previous time step. 

CRW was originally developed for describing the movement of insects (e.g. Kareiva & Schigesada 1983, Turchin 1998) and fitted to observational movement data. It has been shown that CRW describes well the movement behaviour not only of insects (e.g. Schtickzelle et al. 2007, Schultz and Crone 2001) but also other animals, e.g. sea stars (Lohmann et al. 2016), caribou (Bergmann et al. 2000), and grey seals (Austin et al. 2004). Accordingly, CRW is often used to represent animal movement in agent-based models (e.g. butterflies: Schultz and Crone 2005, Radchuk et al. 2013, wild boars: Scherer et al. 2020).

## 5. Concepts

The key concept that CRW is based on is that of movement. Movement is defined as a change in the spatial location of an individual over time and is a key behavioural process that shapes ecological and evolutionary processes of nearly all animals (Nathan 2008). By affecting spatial position of individuals, movement shapes spatial patterns of individuals within populations and thereby affects metapopulation dynamics (Hanski 1998), species distribution (Hodgson et al. 2022) and, more generally, biodiversity dynamics (Jeltsch et al. 2013).   
Different types of movement can be differentiated (Schlaegel et al. 2020) and CRW is useful for describing movement when focusing on local temporal and spatial scales.  

## 6. An overview of the RBB and its use 

### - Entity

    - __What entity, or entities, are running the submodel or are involved (e.g., by providing information)? What state variables does the entity need to have to run this RBB?__   
    The entities that call CRW are individual animals. Each individual possesses two state variables: move length and turning angle. These state variables are updated at each time step.


### - Context, model parameters & patterns: 

    - __What global variables (e.g., parameters characterising the environment) or data structures (e.g., a gridded spatial environment) does the use of the RBB require?__     
    The RBB requires the current x and y coordinates of the calling agent, and the values of the parameters describing the distributions from which the turning angle and the move length will be drawn.   
    - __Does the RBB directly affect global variables or data structures?__  
    No, RBB does not modify global variables, only the state variables (i.e. x and y coordinates) of the individual are affected.  
    - __What parameters does the RBB use? Preferably a table including parameter name, meaning, default value, range, and unit (if applicable).__   
    Move length is typically chosen from lognormal distribution, so that parameters defining this distribution are needed.    
    
    | name | meaning | units | typical ranges | 
    | -------- | -------- | -------- | -------- | 
    | mu     | Mean of the lognormal distribution, from which the move length is drawn | meters | ($-\infty$, $\infty$)|
    | sd     | Standard deviation of the lognormal distribution, from which the move length is drawn | meters |  (0, $\infty$)|
    
    Turning angles are drawn from appropriate distributions. We present here two ways to model turning angles:
    - implementation #1: chosen from uniform distribution    
    This is a rather simple and very often used implementation for choosing the turning angle. The angle is drawn from a uniform distribution within a specified range of possible headings (e.g. between -30 and +30 degrees).
    - implementation #2: drawn from a von Mises distribution   
    A common but more sophisticated solution is the drawing of the turning angle from one kind of a circular distribution, e.g., from a von Mises distribution, wrapped Cauchy distribution, or wrapped normal distribution (Codling et al. 2008). Our second implementation example uses a von Mises distribution. The description of this distribution also requires two parameters namely a mean (m) and a concentration (K).
    
    __Parameters for turning angles according to implementation #1__
    | name | meaning | units | typical ranges | 
    | -------- | -------- | -------- | -------- | 
    | angle     | +/- values of turn | radians | [0, $2\times\pi$] |
    
    __Parameters for turning angles according to implementation #2__
    | name | meaning | units | typical ranges | 
    | -------- | -------- | -------- | -------- | 
    | m     | Mean of the von Mises distribution, from which the turning angle is drawn | radians |  [0, $2\times\pi$] |
    | K     | Concentration parameter of the von Mises distribution, used for drawing the turning angles | unitless  | (0, $\infty$) |


### - Patterns and data to determine  parameters and/or to claim that the RBB is realistic enough for its purpose:

    - __Which of the variables (or parameters) can be set independent of the model/RBB, using direct measurement, other models (e.g. regression) , etc.?__   
    If following implementation #2, all parameters can be estimated by analysing the movement data collected on a sample of individuals of the studied species, e.g. by means of GPS, telemetry or ATLAS (Advanced Tracking and Localization of Animals in real-life Systems).   
    If following implementation #1 the parameters describing the range from which the turning angles are to be drawn may be specified directly by the user, but that would not necessarily reflect movement ecology of the species in consideration.  
    
    - __Which variables or parameters can only be estimated within the context of the model or require calibration?__
    If following implementation #1, the range of the headings out of which to draw the turning angle has to be calibrated.    
    For implementation #2, on contrary, all parameters can be parameterised using empirical data, no calibration is required. 

    - __Which data or patterns can be used for calibration?__   
    Spatial movement data can be used for calibration. These data can be collected in various ways, e.g. by using GPS, telemetry or ATLAS (Advanced Tracking and Localization of Animals in real-life Systems). A pattern that can be used to calibrate the range of headings for implementation #1, for example, is a spatial point pattern of the location of a sample of individuals at a time points separated by longer periods (compared to the time step of the model).     
    
    - __Are pre-existing datasets available to users already exist (references)?__
    CRW was already applied to several species previously and the data to derive the CRW parameters exist for a large number of species that were tracked by means of telemetry. Examples of data collected for modelling the animal movement as CRW:

1. Schtickzelle, N., Joiris, A., van Dyck, H., & Baguette, M. (2007). Quantitative analysis of changes in movement behaviour within and outside habitat in a specialist butterfly. BMC Evolutionary Biology, 7. https://doi.org/4 10.1186/1471-2148-7-4
2. Root, R. B., & Kareiva, P. M. (1984). The search for resources by cabbage butterflies (Pieris rapae): ecological consequences and adaptive significance of Markovian movements in a patchy environment. Ecology, 65(1), 147–165. https://doi.org/10.2307/1939467


- Interface - A list of all inputs and outputs of the RBB

    - __Which input variables that  the RBB requires from an external, calling entity and in which units?__
    
    - __What specific outputs does it produce and how does this update the state variables of the calling entity?__

_this has to be updated!_
- Inputs: The RBB requires the current x and y coordinates of the calling entity, and the values of the parameters describing the distributions from which the turning angle and the move length will be drawn.
- Outputs: The RBB produces the coordinates (x and y) of the next location to which the entity will be moving.


## Narrative Documentation

The entities that call CRW are individual animals.   
Each individual possesses two state variables: move length and turning angle. These state variables are updated at each time step.   
At each time step the RBB calculates the turning angle of the individual (that correlates with the previous heading of the individual) and its move length. The RBB then uses these values to update the location of the individual to the new one.   
The processes in the model are scheduled as follows: first the turning angle is calculated using a specific distribution, and next the move length is calculated, so that the new x and y coordinates can be calculated, to which the individual moves.  


## Reference Implementation and Use Cases

This RBB includes an implementation of CRW in NetLogo version 6.2.2 run on MacOS Monterey 12.2.1


## Relationship to other RBBs

Durable references (i.e., permanent identifiers or URLs) to other related RBBs.


## General Metadata

- authors: Viktoriia Radchuk, Thibault Fronville, Uta Berger
- version:  v 1.0.0 _Okay?_
- license
- programming language and version: NetLogo version 6.2.2
- software, system, and data dependencies: 
- repository URL (NOTE: needs clarification, is this the _development_ repository like the URL of this GitHub repository, or a TRUSTed digital repository for
  archival, like https://doi.org/10.5281/zenodo.7241586?)
- peer reviewed (yes/no): __Don't know what to fill in, reviewed by whom?__
- date published: 
- date last update: 

## Software Citation and FAIR4RS Principles

Viktoriia Radchuk, Thibault Fronville, Uta Berger (202X) ‘Correlated random walk (CRW) to model individual movement in homogeneous landscapes’   
__to be updated__

Create a citation for this RBB according to the 
[Software Citation Principles](https://force11.org/info/software-citation-principles-published-2016/). 

  

## Documentation and Use

### Entity
<span style = "color:orange"> __now I am confused: this was already part of Tier 1, section 'Narrative documentation' (as part of Overview in the ODD). Do we really need to repeat it here?__</span>
 
- What entity, or entities, are running the submodel? What state variables does the entity need to have to run this RBB?
- Which variables describe the entities (normally derived from state variables) 

### Context, model parameters & patterns:

-   What global variables (e.g., parameters characterizing the environment) or data structures (e.g., a gridded spatial environment) does the use of the RBB require?   

The environment has to have x and y coordinates so that the location of an individual at the next step can be calculated based on the chosen turning angle and the particular move length. Although quite many CRW models were implemented in a gridded spatial environment, a grid is not a prerequisite for modelling movement as CRW, but the usage of continuous coordinates is also possible.   

-   Does the RBB directly affect global variables or data structures? 

Global variables are not modified by individuals’ movement, only the state variables (i.e. x and y coordinates) of the individual are affected.     

-   Which parameters does the RBB use? Preferably a table including parameter name, meaning, default value, range, and unit (if applicable)    


### Patterns and data to determine global variables & parameters and/or to claim that the model is realistic enough for its purpose

-  Which of the variables (or parameters) have an empirical meaning and can, in principle, be determined directly?   

If following implementation #2, all parameters can be estimated by analysing the movement data collected on a sample of individuals of the studied species, e.g. by means of GPS, telemetry or ATLAS (Advanced Tracking and Localization of Animals in real-life Systems).      

-  Which variables can be only determined via calibration?   

If following implementation #2, all parameters can be parameterised using empirical data, there are no parameters that would specifically require calibration.  
However, if implementation #1 is used, the range of the headings out of which to draw the turning angle would have to be calibrated.    

-  Which data or patterns can be used for calibration?   

Spatial movement data can be used for calibration. These data can be collected in various ways, e.g. by using GPS, telemetry or ATLAS (Advanced Tracking and Localization of Animals in real-life Systems). A pattern that can be used to calibrate the range of headings for implementation #1, for example, is a spatial point pattern of the location of a sample of individuals at a time points separated by longer periods (compared to the time step of the model).     

-  Which data sets already exist? (include durable references)

Examples of data collected for modelling the animal movement as CRW:

1. Schtickzelle, N., Joiris, A., van Dyck, H., & Baguette, M. (2007). Quantitative analysis of changes in movement behaviour within and outside habitat in a specialist butterfly. BMC Evolutionary Biology, 7. https://doi.org/4 10.1186/1471-2148-7-4
2. Root, R. B., & Kareiva, P. M. (1984). The search for resources by cabbage butterflies (Pieris rapae): ecological consequences and adaptive significance of Markovian movements in a patchy environment. Ecology, 65(1), 147–165. https://doi.org/10.2307/1939467


### Interface

- What specific inputs does the RBB require from an external, calling entity and in what units (e.g., [CSDMS Standard Names](https://csdms.colorado.edu/wiki/CSN_Examples) and [UDUnits](https://www.unidata.ucar.edu/software/udunits/))?
- What specific outputs does it produce and how does this update the state variables of the calling entity?

### Scales
- On which spatio-temporal scales does the RBB work, i.e. what are the resolution and extent of the spatial and temporal scale?

### Details

How, in detail, does the RBB work? This should be written description that
describes the code implementing the RBB and can include equations and
pseudo-code which is particularly important if the RBB involves several
processes.

- include a flowchart if appropriate

### Source Code

Provided in a format that is readable by compilers/development environments,
well commented, written for which programming language, operation system,
version etc., if possible, provided for different programming languages

## Example implementation

An executable deployment that includes a simplified environment in which the RBB can be run.

## Example analyses of a simulation output, benchmark, or test cases

Results obtained with the example implementation providing insights into how,
under different settings, the RBB performs, including extreme scenarios.

## Use history

What is the history of the RBB? Is it entirely new or based on earlier
submodels, or an implementation of an existing submodel? 

Has the RBB, or its predecessors, been used in literature?

Include a reference list of publications where the RBB was successfully used.

## User's guide | manual | tutorial

For more complex RBBs, a detailed user's guide or manual and a tutorial walk through can be very helpful to onboard new users.

## References

As needed.
