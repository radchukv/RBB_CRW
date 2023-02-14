# Reusable Building Blocks

# Tier 1

## Name

Correlated Random Walk (CRW)

## Purpose

CRW is often used to represent the movement of animal individuals, in two-dimensional space. It is characterized by the fact that the direction of movement at any time step is correlated with the direction of movement at the previous time step. 

CRW was originally developed for describing the movement of insects (e.g. Kareiva & Schigesada 1983, Turchin 1998) and fitted to observational movement data. It has been shown that CRW describes well the movement behaviour not only of insects (e.g. Schtickzelle et al. 2007, Schultz and Crone 2001) but also other animals, e.g. sea stars (Lohmann et al. 2016), caribou (Bergmann et al. 2000), and grey seals (Austin et al. 2004). Accordingly, CRW is often used to represent animal movement in agent-based models (e.g. butterflies: Schultz and Crone 2005, Radchuk et al. 2013, wild boars: Scherer et al. 2020).

## Narrative Documentation

_TO BE DONE, not exactly clear to me what goes in here_   
A detailed narrative description of this RBB describing, i.e., its entities, processes, parameters, and scales according
to the rationale of the "Overview" part of the [ODD Protocol](https://www.jasss.org/23/2/7/S1-ODD.pdf). 

A visual representation of the RBB should also be strongly considered to be included, e.g., a
[flowchart](https://en.wikipedia.org/wiki/Flowchart) and/or pseudocode that demonstrates the essential mechanism(s) of
the RBB.

## Reference Implementation and Use Cases

This RBB includes an implementation of CRW in NetLogo version 6.2.2 run on MacOS Monterey 12.2.1

## Inputs and Outputs

- Inputs: The RBB requires the current x and y coordinates of the calling entity, and the values of the parameters describing the distributions from which the turning angle and the move length will be drawn.
- Outputs: The RBB produces the coordinates (x and y) of the next location to which the entity will be moving.

## Relationship to other RBBs

Durable references (i.e., permanent identifiers or URLs) to other related RBBs.

# Tier 2

Tier 2 RBBs require documentation of the RBB in the spirit of the ODD protocol for describing ABMs. After reading Tier 2 RBB documentation a human should be capable of re-implementing the RBB themselves and completely understand what the RBB is doing and how. 

Tier 2 RBBs should meet all Tier 1 requirements with the following additions as well as more detailed descriptions of a few of the Tier 1 fields.

## Keywords

movement, animals, local movement

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

Create a citation for this RBB according to the 
[Software Citation Principles](https://force11.org/info/software-citation-principles-published-2016/). 

This can be easily adopted by editing the 
[CITATION.cff file](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files)
within this repository after
[publishing this RBB in Zenodo](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content). 

Then, edit this section and indicate how you'd like for this RBB to be cited, e.g.,

> Druskat, S., Spaaks, J. H., Chue Hong, N., Haines, R., Baker, J., Bliven, S., Willighagen, E., Pérez-Suárez, D., & Konovalov, A. (2021). Citation File Format (Version 1.2.0) [Computer software]. https://doi.org/10.5281/zenodo.5171937

Be sure to update the citation manually if you go this route and the citation changes.

## Concepts

Describe the theoretical concepts the RBB is building on, e.g., a specific standard description of a certain behavior
such as _symmetric competition_ or the _informed user_. This helps to classify the building block and to develop links
to other similar RBBs.

## Documentation and Use

RBBs are typically relatively short procedures that describe a certain process or interaction. They typically affect a
certain entity, e.g. an agent or a spatial unit, and they are typically run by a certain calling agent, or agents. For
example, a plant uses water, or competes with other plants, a buyer buys somthings, or a farmer is affecting the way how
other farmers use their land. Note that the calling and affecting agents can be the same.

### Entity

- What entity, or entities, are running the submodel? What state variables does the entity need to have to run this RBB?
- Which variables describe the entities (normally derived from state variables) 

### Context, model parameters & patterns:

-   What global variables (e.g., parameters characterizing the environment) or data structures (e.g., a gridded spatial environment) does the use of the RBB require?
-   Does the RBB directly affect global variables or data structures?
-   Which parameters does the RBB use? Preferably a table including parameter name, meaning, default value, range, and unit (if applicable)

### Patterns and data to determine global variables & parameters and/or to claim that the model is realistic enough for its purpose

-  Which of the variables (or parameters) have an empirical meaning and can, in principle, be determined directly?
-  Which variables can be only determined via calibration?
-  Which data or patterns can be used for calibration?
-  Which data sets already exist? (include durable references)

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
